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
puts 'Course'
Course.destroy_all
puts 'Carnet'
Carnet.destroy_all
puts 'User'
User.destroy_all
puts 'CarnetTemplate'
CarnetTemplate.destroy_all
puts 'ShoppingCart'
ShoppingCart.destroy_all
puts 'Order'
Order.destroy_all
puts 'Cities'
City.destroy_all
puts '_________________DROPPING DONE________________'


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
    title: "Equilibre des stocks",
    content: "Facilitez la logistique de vos produits entre vos différents magasins ! Un coursier enlève la marchandise d’un magasin A vers un magasin B ou directement chez votre client, notamment lors des périodes de soldes où les stocks s’écoulent rapidement. Un avantage logistique qui n’est pas dépendant du trafic automobile de la ville.",
    images: "services/gestion_stock_nantes.svg",
    details: "Facilitez la logistique de vos produits entre vos différents magasins ! Un coursier enlève la marchandise d’un magasin A vers un magasin B ou directement chez votre client, notamment lors des périodes de soldes où les stocks s’écoulent rapidement. Un avantage logistique qui n’est pas dépendant du trafic automobile de la ville."
  }
)

Service.create(
  {
    title: "Mutualisation",
    content: "Du ramassage de courrier à la tournée de livraison  de flyers et prospectus commercial, optez pour une solution rapide, économique et eco-friendly. Nos coursiers peuvent récupérer vos colis dans vos agences pour mutualiser la livraison, ou inversement. Profitez de nos vélos cargos pour faire livrer de nombreux colis ou objets encombrants ! ",
    images: "services/mutualisation.svg",
    details: "Du ramassage de courrier à la tournée de livraison  de flyers et prospectus commercial, optez pour une solution rapide, économique et eco-friendly. Nos coursiers peuvent récupérer vos colis dans vos agences pour mutualiser la livraison, ou inversement. Profitez de nos vélos cargos pour faire livrer de nombreux colis ou objets encombrants ! ",
  }
)

Service.create(
  {
    title: "Privatisation",
    content: "Privatisez un de nos livreur coursier pour l’organisation et le déroulement de vos événements ! Mettez à votre dispositions des mollets de compétitions pour anticiper et gérer tous vos besoins de transport de matériel et autres éléments avec la plus grande rapidité et réactivité. Adieu le problème des bouchons ! ",
    images: "services/privatisation_de_coursier.svg",
    details: "Privatisez un de nos livreur coursier pour l’organisation et le déroulement de vos événements ! Mettez à votre dispositions des mollets de compétitions pour anticiper et gérer tous vos besoins de transport de matériel et autres éléments avec la plus grande rapidité et réactivité. Adieu le problème des bouchons ! "
  }
)

Service.create(
  {
    title: "Gestion de boîte postale",
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
    title: "Sur mesure",
    content: "Vous avez un besoin ou une demande particulière pour nous ?
    Bici Couriers s’engage à réaliser tous les défis (dans la limite du réalisable). On vous parie qu’on y arrivera #transportdecanapé.
    Nous proposons également des abonnements et carnets de tickets pour les demandes récurrentes. ",
    images: "services/livraisons_sur_mesure.svg",
    details: "Vous avez un besoin ou une demande particulière pour nous ?
    Bici Couriers s’engage à réaliser tous les défis (dans la limite du réalisable). On vous parie qu’on y arrivera #transportdecanapé.
    Nous proposons également des abonnements et carnets de tickets pour les demandes récurrentes. "
  }
)
puts '________________SERVICES => OK________________'

puts '__________________AVANTAGES___________________'

Avantage.create(
  {
    image_pour: "avantages/co2.svg",
  }
)
Avantage.create(
  {
    image_pour: "avantages/logique.svg",
  }
)
Avantage.create(
  {
    image_pour: "avantages/courbature.svg",
  }
)
Avantage.create(
  {
    image_pour: "avantages/sympa.svg",
  }
)
Avantage.create(
  {
    image_pour: "avantages/stress.svg",
  }
)
puts '_______________AVANTAGES => OK________________'
puts '____________________USERS_____________________'

florent = User.create(
  {
    email: "kiki@bicicouriers.fr",
    password: "secret",
    phone: "0674236080",
    first_name: "Florent",
    last_name: "Guilbaud",
    company: "BiciCouriers"
  }
)

admin = User.create(
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

# ticket_solo = CarnetTemplate.create(
#   {
#     ticket_nb: 0,
#     price_cents: 700,
#     description: "Sans carnet, le service à la carte !",
#     image: "tarifs/ticket-1.svg"
#   }
# )
puts '______________CARNETS TEMPLATES_______________'

carnet_10_t = CarnetTemplate.create(
  {
    ticket_nb: 10,
    price_cents: 500,
    description: "Carnet de 10 tickets pour les petits besoins ponctuels.",
    image: "tarifs/ticket-1.svg",
    distance_max: 3.5
  }
)

carnet_20_t = CarnetTemplate.create(
  {
    ticket_nb: 20,
    price_cents: 480,
    description: "20 tickets pour une utilisation un peu plus régulière.",
    image: "tarifs/ticket-1.svg",
    distance_max: 3.5
  }
)

carnet_50_t = CarnetTemplate.create(
  {
    ticket_nb: 50,
    price_cents: 440,
    description: "Carnet de 50 tickets destinés à des besoins quotidiens !",
    image: "tarifs/ticket-1.svg",
    distance_max: 3.5
  }
)

carnet_100_t = CarnetTemplate.create(
  {
    ticket_nb: 100,
    price_cents: 420,
    description: "Carnet de 100 tickets destinés à de gros besoin et économiser sur vos livraisons !",
    image: "tarifs/ticket-1.svg",
    distance_max: 3.5
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

puts '_________________SHOPPING CART________________'

shop_1 = ShoppingCart.create(
  {
    price_cents: 22000,
    user_id: florent.id,
    state: :paid
  }
)

puts '_____________SHOPPING CART => OK______________'

puts '___________________CARNETS____________________'


carnet_50 = Carnet.create(
  {
    carnet_template_id: carnet_50_t.id,
    user_id: florent.id,
    remaining_tickets: 50,
    shopping_cart_id: shop_1.id
  }
)

puts '________________CARNETS => OK_________________'

puts '___________________CITIES_____________________'

nantes = City.create(city_name: "Nantes")


puts '________________CITIES => OK__________________'



puts "ok"






























