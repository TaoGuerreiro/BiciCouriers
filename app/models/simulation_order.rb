class SimulationOrder < ApplicationRecord
  belongs_to :simulation

  monetize :amount_cents
  # after_create :send_info_to_dispatch

  before_save :send_info_to_dispatch, if: :will_save_change_to_state?

  # after_update do
  #   send_info_to_dispatch if: :will_save_change_to_status_id?
  # end


  private

  def send_info_to_dispatch
    DispatchMailer.with(simulation: self.simulation).new_simulation.deliver_now
  end
end
