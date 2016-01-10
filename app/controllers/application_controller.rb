class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
    @count_urls = Url.count()
    if request.url.include?("secubat")
      redirect_to secubat_clients_path
    end
  end

  def dns_availability
    extensions = [".com", ".org", ".net"]
    el =  ["Kallium", "Calcium", "Scandium", "Titane", "Vanadium", "Chrome", "Manganese", "Fer", "Cobalt", "Nickel", "Cuivre", "Zinc", "Gallium", "Germanium", "Arsenic", "Selenium", "Brome", "Krypton",
      "Helium", "Neon", "Argon", "Krypton", "Xenon", "Radon",
      "Fluor", "Chlore", "Brome", "Iode", "Astate",
      "Oxygene", "Soufre", "Selenium", "Tellure", "Polonium",
      "Nitrogene", "Azote", "Phosphore", "Arsenic", "Stibium", "Antimoine", "Bismuth",
      "Carbone", "Silicium", "Germanium", "Stannum", "etain", "Plomb",
      "Bore", "Aluminium", "Gallium", "Indium", "Thallium",
      "Beryllium", "Magnesium", "Calcium", "Strontium", "Baryum", "Radium",
      "Hydrogene", "Lithium", "Natrium", "Sodium", "Kallium", "Potassium", "Rubidium", "Cesium", "Francium",
      "Actinium", "Thorium", "Protactinium", "Uranium", "Neptunium", "Plutonium", "Americium", "Curium", "Berkelium", "Californium", "Einsteinium", "Fermium", "Mendelenium", "Nobelium", "Lawrencium",
      "Lanthane", "Cerium", "Praseodyme", "Neodyme", "Promethium", "Samarium", "Europium", "Gadolinium", "Terbium", "Dysprosium", "Holmium", "Erbium", "Thullium", "Ytterbium", "Lutecium",
      "Francium", "Radium", "Actinium", "Rutherfordium", "Dubnium", "Seaborgium", "Bohrium", "Hassium", "Meitnerium",
      "Cesium", "Baryum", "Lanthane", "Hafnium", "Tantale", "Wolfram", "Tungstene", "Rhenium", "Osmium", "Iridium", "Platine", "Aurum", "Or", "Hydrargirum", "Mercure", "Thallium", "Plomb", "Bismuth", "Polonium", "Astate", "Radon",
      "Rubidium", "Strontium", "Yttrium", "Zirconium", "Niobium", "Molybdene", "Technetium", "Ruthenium", "Rhodium", "Palladium", "Argent", "Cadmium", "Indium", "Stannum", "etain", "Stibium", "Antimoine", "Tellure", "Iode", "Xenon",
      "Kallium", "Potassium", "Calcium", "Scandium", "Titane", "Vanadium", "Chrome", "Manganese", "Fer", "Cobalt", "Nickel", "Cuivre", "Zinc", "Gallium", "Germanium", "Arsenic", "Selenium", "Brome", "Krypton",
      "Sodium", "Magnesium", "Aluminium", "Silicium", "Phosphore", "Soufre", "Chlore", "Argon",
      "Lithium", "Beryllium", "Bore", "Carbone", "Nitrogene", "Azote", "Oxygene", "Fluor", "Neon"]

    beta = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    alpha = beta #.shuffle
    puts alpha
    @dns = {}
    i = 0
    j = 0
    extensions.each do |extension|
      alpha.each do |dns|
        alpha.last(25).each do |dns2|
          puts "-----------------------------------------------------------------------> #{dns}#{dns2}XX"
          puts alpha
          alpha.last(26).each do |dns3|
            alpha.last(25).each do |dns4|
                #available = Whois.available?("#{dns.downcase}#{extension}")
                j += 1
                begin
                  packet = Net::DNS::Resolver.start("#{dns}#{dns2}#{dns3}#{dns4}#{extension}").answer
                  available ||= true
                  if packet.any?
                    available = false
                  end

                  #sleep 3
                  if (available == true)
                    available = Whois.available?("#{dns}#{dns2}#{dns3}#{dns4}#{extension}")
                    if available == true
                      i += 1
                      @dns["#{dns}#{dns2}#{dns3}#{dns4}#{extension}"] = available
                      puts "[#{available.to_s.upcase}] [#{i}] --------------------------------> [#{dns}#{dns2}#{dns3}#{dns4}#{extension}] ****************************************"
                    end
                  end
                  return if i > 500000 or j > 10000000
                rescue
                  available = false
                  puts "[RESCUE #{available.to_s.upcase}] #{dns}#{dns2}#{dns3}#{dns4}#{extension}"
                end

            end
          end
        end
      end
    end
  end
end
