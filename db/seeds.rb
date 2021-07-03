# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seeding"
puts '______________DROPPING TABLES_________________'
puts 'Services'
Service.destroy_all
puts 'Avantage'
Avantage.destroy_all
puts 'Bike'
Bike.destroy_all
puts 'Pickup'
Pickup.destroy_all
puts 'Drop'
Drop.destroy_all
puts 'Favorite Addresses'
FavoriteAddress.destroy_all
puts 'Delivery'
Delivery.destroy_all
puts 'Carnet'
TicketsBook.destroy_all
puts 'User'
User.destroy_all
puts 'CarnetTemplate'
BookTemplate.destroy_all
puts 'ShoppingCart'
OrderItem.destroy_all
puts 'Order'
Order.destroy_all
puts 'Cities'
City.destroy_all
puts 'Options'

Option.destroy_all

puts 'UserOptions'
UserOption.destroy_all
puts 'CourseOptions'
DeliveryOption.destroy_all

puts '_________________DROPPING DONE________________'

puts '___________________CITIES_____________________'

  nantes = City.create!(name: "Nantes")

puts '________________CITIES => OK__________________'


puts '___________________SERVICES___________________'
  Service.create(
    {
      title: "Transport urgent",
      content: "Vous avez une demande express ? Vous souhaitez faire livrer une lettre ou un colis pendant les heures de pointes ? La livraison express  par coursiers à vélos sur Nantes est la plus rapide ! Nos coursiers pratique le cyclisme sportif et mettent leur efficacité à votre service en livrant votre colis 45 minutes seulement après votre demande.",
      images: "services/transport_urgent_nantes.svg",
      details:  "Vous avez une demande express ? Vous souhaitez faire livrer une lettre ou un colis pendant les heures de pointes ? La livraison express  par coursiers à vélos sur Nantes est la plus rapide ! Nos coursiers pratique le cyclisme sportif et mettent leur efficacité à votre service en livrant votre colis 45 minutes seulement après votre demande.",

    }
  )

  Service.create(
    {
      title: "Equilibre des vos stocks",
      content: "Facilitez la logistique de vos produits entre vos différents magasins ! Un coursier enlève la marchandise d’un magasin A vers un magasin B ou directement chez votre client, notamment lors des périodes de soldes où les stocks s’écoulent rapidement. Un avantage logistique qui n’est pas dépendant du trafic automobile de la ville.",
      images: "services/gestion_stock_nantes.svg",
      details: "Facilitez la logistique de vos produits entre vos différents magasins ! Un coursier enlève la marchandise d’un magasin A vers un magasin B ou directement chez votre client, notamment lors des périodes de soldes où les stocks s’écoulent rapidement. Un avantage logistique qui n’est pas dépendant du trafic automobile de la ville."
    }
  )

  Service.create(
    {
      title: "Mutualisation de vos flux de transport",
      content: "Du ramassage de courrier à la tournée de livraison  de flyers et prospectus commercial, optez pour une solution rapide, économique et eco-friendly. Nos coursiers peuvent récupérer vos colis dans vos agences pour mutualiser la livraison, ou inversement. Profitez de nos vélos cargos pour faire livrer de nombreux colis ou objets encombrants ! ",
      images: "services/mutualisation.svg",
      details: "Du ramassage de courrier à la tournée de livraison  de flyers et prospectus commercial, optez pour une solution rapide, économique et eco-friendly. Nos coursiers peuvent récupérer vos colis dans vos agences pour mutualiser la livraison, ou inversement. Profitez de nos vélos cargos pour faire livrer de nombreux colis ou objets encombrants ! ",
    }
  )

  Service.create(
    {
      title: "Privatisation de coursiers",
      content: "Privatisez un de nos livreur coursier pour l’organisation et le déroulement de vos événements ! Mettez à votre dispositions des mollets de compétitions pour anticiper et gérer tous vos besoins de transport de matériel et autres éléments avec la plus grande rapidité et réactivité. Adieu le problème des bouchons ! ",
      images: "services/privatisation_de_coursier.svg",
      details: "Privatisez un de nos livreur coursier pour l’organisation et le déroulement de vos événements ! Mettez à votre dispositions des mollets de compétitions pour anticiper et gérer tous vos besoins de transport de matériel et autres éléments avec la plus grande rapidité et réactivité. Adieu le problème des bouchons ! "
    }
  )

  Service.create(
    {
      title: "Gestion du courrier entreprise",
      content: "La légendaire tournée du facteur est trop tardive ?
      Bici Couriers répond à votre demande en toute simplicité. Choisissez une heure de dépôt et de retrait du courrier et laissez vous du temps pour faire autre chose.
      Plus besoin de courir à la poste avant qu’elle ferme !",
      images: "services/relai_poste.svg",
      details: "La légendaire tournée du facteur est trop tardive ?
      Bici Couriers répond à votre demande en toute simplicité. Choisissez une heure de dépôt et de retrait du courrier et laissez vous du temps pour faire autre chose.
    Plus besoin de courir à la poste avant qu’elle ferme !"
    }
  )

  Service.create(
    {
      title: "Votre coursier sur mesure",
      content: "Vous avez un besoin ou une demande particulière pour nous ?
      BiciCouriers s’engage à réaliser tous les défis (dans la limite du réalisable). On vous parie qu’on y arrivera #transportdecanapé.
      Nous proposons également des abonnements et carnets de tickets pour les demandes récurrentes et des prix attractifs. ",
      images: "services/livraisons_sur_mesure.svg",
      details: "Vous avez un besoin ou une demande particulière pour nous ?
      Bici Couriers s’engage à réaliser tous les défis (dans la limite du réalisable). On vous parie qu’on y arrivera #transportdecanapé.
      Nous proposons également des abonnements et carnets de tickets pour les demandes récurrentes. "
    }
  )
puts '________________SERVICES => OK________________'

puts '__________________AVANTAGES___________________'

  Avantage.create!(
    {
      image_pour: "avantages/co2.svg",
      city_id: nantes.id
    }
  )
  Avantage.create!(
    {
      image_pour: "avantages/logique.svg",
      city_id: nantes.id
    }
  )
  Avantage.create!(
    {
      image_pour: "avantages/courbature.svg",
      city_id: nantes.id
    }
  )
  Avantage.create!(
    {
      image_pour: "avantages/sympa.svg",
      city_id: nantes.id
    }
  )
  Avantage.create!(
    {
      image_pour: "avantages/stress.svg",
      city_id: nantes.id
    }
  )
puts '_______________AVANTAGES => OK________________'

puts '____________________USERS_____________________'

  florent = User.create!(
    {
      email: "kiki@bicicouriers.fr",
      address: '8 passage de la Poule Noire, 44000 Nantes',
      password: "secret",
      phone: "0674236080",
      first_name: "Florent",
      last_name: "Guilbaud",
      company: "BiciCouriers"
    }
  )

  admin = User.create!(
    {
      email: "florent@bicicouriers.fr",
      password: "secret",
      phone: "0781116670",
      first_name: "Florent",
      last_name: "Guilbaud",
      company: "BiciCouriers",
      admin: true
    }
  )
puts '________________USERS => OK___________________'

puts '______________TICKETSBOOK TEMPLATES_______________'

  carnet_10_t = BookTemplate.create!(
    {
      tickets_count: 10,
      price_cents: 500,
      description: "Carnet de 10 tickets pour les petits besoins ponctuels.",
      image: "tarifs/ticket-1.svg",
      max_distance: 3500
    }
  )

  carnet_20_t = BookTemplate.create!(
    {
      tickets_count: 20,
      price_cents: 480,
      description: "20 tickets pour une utilisation un peu plus régulière.",
      image: "tarifs/ticket-1.svg",
      max_distance: 3500
    }
  )

  carnet_50_t = BookTemplate.create!(
    {
      tickets_count: 50,
      price_cents: 440,
      description: "Carnet de 50 tickets destinés à des besoins quotidiens !",
      image: "tarifs/ticket-1.svg",
      max_distance: 3500
    }
  )

  carnet_100_t = BookTemplate.create!(
    {
      tickets_count: 100,
      price_cents: 420,
      description: "Carnet de 100 tickets destinés à de gros besoin et économiser sur vos livraisons !",
      image: "tarifs/ticket-1.svg",
      max_distance: 3500
    }
  )

puts '___________CARNETS TEMPLATES => OK____________'

puts '____________________BIKES_____________________'

  bike_1 = Bike.create(
    {
      max_weight: 6000,
      max_size: 20000
    }
  )

  bike_2 = Bike.create(
    {
      max_weight: 80000,
      max_size: 2000000
    }
  )

puts '_________________BIKES => OK__________________'
puts '____________________URGENCE___________________'

urgence_1 = Option.create!(
  {
    max_value: 39600,
    name: 'Dans la journée',
    tickets: 0,
    type: 'Urgence',
    image: 'white-box.svg'
  }
)
urgence_2 = Option.create!(
  {
    max_value: 2700,
    name: "Moins de 45 minutes",
    tickets: 2,
    type: 'Urgence',
    image: 'white-box.svg'
  }
)

urgence_3 = Option.create!(
  {
    max_value: 14400,
    name: 'Moins de 4 heures',
    tickets: 1,
    type: 'Urgence',
    image: 'white-box.svg'
  }
)


puts '_________________URGENCE => OK________________'
puts '____________________VOLUME___________________'

volume_1 = Option.create!(
  {
    max_value: 6000,
    name: "- de 6 kilos",
    tickets: 0,
    type: 'Volume',
    image: 'white-box.svg'
  }
)

volume_2 = Option.create!(
  {
    max_value: 15000,
    name: '- de 15 kilos',
    tickets: 1,
    type: 'Volume',
    image: 'white-box.svg'
  }
)

volume_3 = Option.create!(
  {
    max_value: 25000,
    name: '- de 25 kilos',
    tickets: 2,
    type: 'Volume',
    image: 'white-box.svg'
  }
)
volume_4 = Option.create!(
  {
    max_value: 35000,
    name: '- de 35 kilos',
    tickets: 3,
    type: 'Volume',
    image: 'white-box.svg'
  }
)
puts '_________________VOLUME => OK________________'

puts '___________________TICKETS BOOK____________________'


  carnet_50 = TicketsBook.create!(
    {
      book_template_id: carnet_50_t.id,
      user_id: florent.id,
      remaining_tickets: 50,
      status: 'draft',
      price_cents: carnet_50_t.price_cents
    }
  )

puts '________________CARNETS => OK_________________'

puts '___________________CITY OPTIONS_____________________'

option_1 = CityOption.create!({city_id: nantes.id, option_id: urgence_1.id, rank: 1})
option_3 = CityOption.create!({city_id: nantes.id, option_id: urgence_2.id, rank: 2})
option_2 = CityOption.create!({city_id: nantes.id, option_id: urgence_3.id, rank: 3})
option_4 = CityOption.create!({city_id: nantes.id, option_id: volume_1.id})
option_4 = CityOption.create!({city_id: nantes.id, option_id: volume_2.id})
option_5 = CityOption.create!({city_id: nantes.id, option_id: volume_3.id})


puts '________________CITY OPTIONS => OK__________________'


puts '___________________USER OPTIONS_____________________'

# option_1 = UserOption.create!({user_id: florent.id, option_id: deux_heures.id})
# option_3 = UserOption.create!({user_id: florent.id, option_id: quarante_cinq_minutes.id})
# option_2 = UserOption.create!({user_id: florent.id, option_id: gros_volume.id})
# option_4 = UserOption.create!({user_id: florent.id, option_id: tres_gros_volume.id})
# option_5 = UserOption.create!({user_id: florent.id, option_id: nourriture.id})


puts '________________USER OPTIONS => OK__________________'





puts "ok"
