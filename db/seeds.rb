# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding.."
p = Player.new({:username => "Bye", :login => "Bye", :email => "Bye", :name => "Bye", :password => "Bye@By.e", :password_confirmation => "Bye@By.e"}, :as => :seed)
p.save(:validate => false)

Country.create({:iso => 'AF', :printable_name => 'AFGHANISTAN', :name => 'Afghanistan', :iso3 => 'AFG', :numcode => '004'}, :as => :seed)
Country.create({:iso => 'AL', :printable_name => 'ALBANIA', :name => 'Albania', :iso3 => 'ALB', :numcode => '008'}, :as => :seed)
Country.create({:iso => 'DZ', :printable_name => 'ALGERIA', :name => 'Algeria', :iso3 => 'DZA', :numcode => '012'}, :as => :seed)
Country.create({:iso => 'AS', :printable_name => 'AMERICAN SAMOA', :name => 'American Samoa', :iso3 => 'ASM', :numcode => '016'}, :as => :seed)
Country.create({:iso => 'AD', :printable_name => 'ANDORRA', :name => 'Andorra', :iso3 => 'AND', :numcode => '020'}, :as => :seed)
Country.create({:iso => 'AO', :printable_name => 'ANGOLA', :name => 'Angola', :iso3 => 'AGO', :numcode => '024'}, :as => :seed)
Country.create({:iso => 'AI', :printable_name => 'ANGUILLA', :name => 'Anguilla', :iso3 => 'AIA', :numcode => '660'}, :as => :seed)
Country.create({:iso => 'AG', :printable_name => 'ANTIGUA AND BARBUDA', :name => 'Antigua and Barbuda', :iso3 => 'ATG', :numcode => '028'}, :as => :seed)
Country.create({:iso => 'AR', :printable_name => 'ARGENTINA', :name => 'Argentina', :iso3 => 'ARG', :numcode => '032'}, :as => :seed)
Country.create({:iso => 'AM', :printable_name => 'ARMENIA', :name => 'Armenia', :iso3 => 'ARM', :numcode => '051'}, :as => :seed)
Country.create({:iso => 'AW', :printable_name => 'ARUBA', :name => 'Aruba', :iso3 => 'ABW', :numcode => '533'}, :as => :seed)
Country.create({:iso => 'AU', :printable_name => 'AUSTRALIA', :name => 'Australia', :iso3 => 'AUS', :numcode => '036'}, :as => :seed)
Country.create({:iso => 'AT', :printable_name => 'AUSTRIA', :name => 'Austria', :iso3 => 'AUT', :numcode => '040'}, :as => :seed)
Country.create({:iso => 'AZ', :printable_name => 'AZERBAIJAN', :name => 'Azerbaijan', :iso3 => 'AZE', :numcode => '031'}, :as => :seed)
Country.create({:iso => 'BS', :printable_name => 'BAHAMAS', :name => 'Bahamas', :iso3 => 'BHS', :numcode => '044'}, :as => :seed)
Country.create({:iso => 'BH', :printable_name => 'BAHRAIN', :name => 'Bahrain', :iso3 => 'BHR', :numcode => '048'}, :as => :seed)
Country.create({:iso => 'BD', :printable_name => 'BANGLADESH', :name => 'Bangladesh', :iso3 => 'BGD', :numcode => '050'}, :as => :seed)
Country.create({:iso => 'BB', :printable_name => 'BARBADOS', :name => 'Barbados', :iso3 => 'BRB', :numcode => '052'}, :as => :seed)
Country.create({:iso => 'BY', :printable_name => 'BELARUS', :name => 'Belarus', :iso3 => 'BLR', :numcode => '112'}, :as => :seed)
Country.create({:iso => 'BE', :printable_name => 'BELGIUM', :name => 'Belgium', :iso3 => 'BEL', :numcode => '056'}, :as => :seed)
Country.create({:iso => 'BZ', :printable_name => 'BELIZE', :name => 'Belize', :iso3 => 'BLZ', :numcode => '084'}, :as => :seed)
Country.create({:iso => 'BJ', :printable_name => 'BENIN', :name => 'Benin', :iso3 => 'BEN', :numcode => '204'}, :as => :seed)
Country.create({:iso => 'BM', :printable_name => 'BERMUDA', :name => 'Bermuda', :iso3 => 'BMU', :numcode => '060'}, :as => :seed)
Country.create({:iso => 'BT', :printable_name => 'BHUTAN', :name => 'Bhutan', :iso3 => 'BTN', :numcode => '064'}, :as => :seed)
Country.create({:iso => 'BO', :printable_name => 'BOLIVIA', :name => 'Bolivia', :iso3 => 'BOL', :numcode => '068'}, :as => :seed)
Country.create({:iso => 'BA', :printable_name => 'BOSNIA AND HERZEGOVINA', :name => 'Bosnia and Herzegovina', :iso3 => 'BIH', :numcode => '070'}, :as => :seed)
Country.create({:iso => 'BW', :printable_name => 'BOTSWANA', :name => 'Botswana', :iso3 => 'BWA', :numcode => '072'}, :as => :seed)
Country.create({:iso => 'BR', :printable_name => 'BRAZIL', :name => 'Brazil', :iso3 => 'BRA', :numcode => '076'}, :as => :seed)
Country.create({:iso => 'BN', :printable_name => 'BRUNEI DARUSSALAM', :name => 'Brunei Darussalam', :iso3 => 'BRN', :numcode => '096'}, :as => :seed)
Country.create({:iso => 'BG', :printable_name => 'BULGARIA', :name => 'Bulgaria', :iso3 => 'BGR', :numcode => '100'}, :as => :seed)
Country.create({:iso => 'BF', :printable_name => 'BURKINA FASO', :name => 'Burkina Faso', :iso3 => 'BFA', :numcode => '854'}, :as => :seed)
Country.create({:iso => 'BI', :printable_name => 'BURUNDI', :name => 'Burundi', :iso3 => 'BDI', :numcode => '108'}, :as => :seed)
Country.create({:iso => 'KH', :printable_name => 'CAMBODIA', :name => 'Cambodia', :iso3 => 'KHM', :numcode => '116'}, :as => :seed)
Country.create({:iso => 'CM', :printable_name => 'CAMEROON', :name => 'Cameroon', :iso3 => 'CMR', :numcode => '120'}, :as => :seed)
Country.create({:iso => 'CA', :printable_name => 'CANADA', :name => 'Canada', :iso3 => 'CAN', :numcode => '124'}, :as => :seed)
Country.create({:iso => 'CV', :printable_name => 'CAPE VERDE', :name => 'Cape Verde', :iso3 => 'CPV', :numcode => '132'}, :as => :seed)
Country.create({:iso => 'KY', :printable_name => 'CAYMAN ISLANDS', :name => 'Cayman Islands', :iso3 => 'CYM', :numcode => '136'}, :as => :seed)
Country.create({:iso => 'CF', :printable_name => 'CENTRAL AFRICAN REPUBLIC', :name => 'Central African Republic', :iso3 => 'CAF', :numcode => '140'}, :as => :seed)
Country.create({:iso => 'TD', :printable_name => 'CHAD', :name => 'Chad', :iso3 => 'TCD', :numcode => '148'}, :as => :seed)
Country.create({:iso => 'CL', :printable_name => 'CHILE', :name => 'Chile', :iso3 => 'CHL', :numcode => '152'}, :as => :seed)
Country.create({:iso => 'CN', :printable_name => 'CHINA', :name => 'China', :iso3 => 'CHN', :numcode => '156'}, :as => :seed)
Country.create({:iso => 'CO', :printable_name => 'COLOMBIA', :name => 'Colombia', :iso3 => 'COL', :numcode => '170'}, :as => :seed)
Country.create({:iso => 'KM', :printable_name => 'COMOROS', :name => 'Comoros', :iso3 => 'COM', :numcode => '174'}, :as => :seed)
Country.create({:iso => 'CG', :printable_name => 'CONGO', :name => 'Congo', :iso3 => 'COG', :numcode => '178'}, :as => :seed)
Country.create({:iso => 'CD', :printable_name => 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', :name => 'Congo, the Democratic Republic of the', :iso3 => 'COD', :numcode => '180'}, :as => :seed)
Country.create({:iso => 'CK', :printable_name => 'COOK ISLANDS', :name => 'Cook Islands', :iso3 => 'COK', :numcode => '184'}, :as => :seed)
Country.create({:iso => 'CR', :printable_name => 'COSTA RICA', :name => 'Costa Rica', :iso3 => 'CRI', :numcode => '188'}, :as => :seed)
Country.create({:iso => 'CI', :printable_name => 'COTE D\'IVOIRE', :name => 'Cote D\'Ivoire', :iso3 => 'CIV', :numcode => '384'}, :as => :seed)
Country.create({:iso => 'HR', :printable_name => 'CROATIA', :name => 'Croatia', :iso3 => 'HRV', :numcode => '191'}, :as => :seed)
Country.create({:iso => 'CU', :printable_name => 'CUBA', :name => 'Cuba', :iso3 => 'CUB', :numcode => '192'}, :as => :seed)
Country.create({:iso => 'CY', :printable_name => 'CYPRUS', :name => 'Cyprus', :iso3 => 'CYP', :numcode => '196'}, :as => :seed)
Country.create({:iso => 'CZ', :printable_name => 'CZECH REPUBLIC', :name => 'Czech Republic', :iso3 => 'CZE', :numcode => '203'}, :as => :seed)
Country.create({:iso => 'DK', :printable_name => 'DENMARK', :name => 'Denmark', :iso3 => 'DNK', :numcode => '208'}, :as => :seed)
Country.create({:iso => 'DJ', :printable_name => 'DJIBOUTI', :name => 'Djibouti', :iso3 => 'DJI', :numcode => '262'}, :as => :seed)
Country.create({:iso => 'DM', :printable_name => 'DOMINICA', :name => 'Dominica', :iso3 => 'DMA', :numcode => '212'}, :as => :seed)
Country.create({:iso => 'DO', :printable_name => 'DOMINICAN REPUBLIC', :name => 'Dominican Republic', :iso3 => 'DOM', :numcode => '214'}, :as => :seed)
Country.create({:iso => 'EC', :printable_name => 'ECUADOR', :name => 'Ecuador', :iso3 => 'ECU', :numcode => '218'}, :as => :seed)
Country.create({:iso => 'EG', :printable_name => 'EGYPT', :name => 'Egypt', :iso3 => 'EGY', :numcode => '818'}, :as => :seed)
Country.create({:iso => 'SV', :printable_name => 'EL SALVADOR', :name => 'El Salvador', :iso3 => 'SLV', :numcode => '222'}, :as => :seed)
Country.create({:iso => 'GQ', :printable_name => 'EQUATORIAL GUINEA', :name => 'Equatorial Guinea', :iso3 => 'GNQ', :numcode => '226'}, :as => :seed)
Country.create({:iso => 'ER', :printable_name => 'ERITREA', :name => 'Eritrea', :iso3 => 'ERI', :numcode => '232'}, :as => :seed)
Country.create({:iso => 'EE', :printable_name => 'ESTONIA', :name => 'Estonia', :iso3 => 'EST', :numcode => '233'}, :as => :seed)
Country.create({:iso => 'ET', :printable_name => 'ETHIOPIA', :name => 'Ethiopia', :iso3 => 'ETH', :numcode => '231'}, :as => :seed)
Country.create({:iso => 'FK', :printable_name => 'FALKLAND ISLANDS (MALVINAS', :name => 'Falkland Islands (Malvinas', :iso3 => 'FLK', :numcode => '238'}, :as => :seed)
Country.create({:iso => 'FO', :printable_name => 'FAROE ISLANDS', :name => 'Faroe Islands', :iso3 => 'FRO', :numcode => '234'}, :as => :seed)
Country.create({:iso => 'FJ', :printable_name => 'FIJI', :name => 'Fiji', :iso3 => 'FJI', :numcode => '242'}, :as => :seed)
Country.create({:iso => 'FI', :printable_name => 'FINLAND', :name => 'Finland', :iso3 => 'FIN', :numcode => '246'}, :as => :seed)
Country.create({:iso => 'FR', :printable_name => 'FRANCE', :name => 'France', :iso3 => 'FRA', :numcode => '250'}, :as => :seed)
Country.create({:iso => 'GF', :printable_name => 'FRENCH GUIANA', :name => 'French Guiana', :iso3 => 'GUF', :numcode => '254'}, :as => :seed)
Country.create({:iso => 'PF', :printable_name => 'FRENCH POLYNESIA', :name => 'French Polynesia', :iso3 => 'PYF', :numcode => '258'}, :as => :seed)
Country.create({:iso => 'GA', :printable_name => 'GABON', :name => 'Gabon', :iso3 => 'GAB', :numcode => '266'}, :as => :seed)
Country.create({:iso => 'GM', :printable_name => 'GAMBIA', :name => 'Gambia', :iso3 => 'GMB', :numcode => '270'}, :as => :seed)
Country.create({:iso => 'GE', :printable_name => 'GEORGIA', :name => 'Georgia', :iso3 => 'GEO', :numcode => '268'}, :as => :seed)
Country.create({:iso => 'DE', :printable_name => 'GERMANY', :name => 'Germany', :iso3 => 'DEU', :numcode => '276'}, :as => :seed)
Country.create({:iso => 'GH', :printable_name => 'GHANA', :name => 'Ghana', :iso3 => 'GHA', :numcode => '288'}, :as => :seed)
Country.create({:iso => 'GI', :printable_name => 'GIBRALTAR', :name => 'Gibraltar', :iso3 => 'GIB', :numcode => '292'}, :as => :seed)
Country.create({:iso => 'GR', :printable_name => 'GREECE', :name => 'Greece', :iso3 => 'GRC', :numcode => '300'}, :as => :seed)
Country.create({:iso => 'GL', :printable_name => 'GREENLAND', :name => 'Greenland', :iso3 => 'GRL', :numcode => '304'}, :as => :seed)
Country.create({:iso => 'GD', :printable_name => 'GRENADA', :name => 'Grenada', :iso3 => 'GRD', :numcode => '308'}, :as => :seed)
Country.create({:iso => 'GP', :printable_name => 'GUADELOUPE', :name => 'Guadeloupe', :iso3 => 'GLP', :numcode => '312'}, :as => :seed)
Country.create({:iso => 'GU', :printable_name => 'GUAM', :name => 'Guam', :iso3 => 'GUM', :numcode => '316'}, :as => :seed)
Country.create({:iso => 'GT', :printable_name => 'GUATEMALA', :name => 'Guatemala', :iso3 => 'GTM', :numcode => '320'}, :as => :seed)
Country.create({:iso => 'GN', :printable_name => 'GUINEA', :name => 'Guinea', :iso3 => 'GIN', :numcode => '324'}, :as => :seed)
Country.create({:iso => 'GW', :printable_name => 'GUINEA-BISSAU', :name => 'Guinea-Bissau', :iso3 => 'GNB', :numcode => '624'}, :as => :seed)
Country.create({:iso => 'GY', :printable_name => 'GUYANA', :name => 'Guyana', :iso3 => 'GUY', :numcode => '328'}, :as => :seed)
Country.create({:iso => 'HT', :printable_name => 'HAITI', :name => 'Haiti', :iso3 => 'HTI', :numcode => '332'}, :as => :seed)
Country.create({:iso => 'VA', :printable_name => 'HOLY SEE (VATICAN CITY STATE', :name => 'Holy See (Vatican City State', :iso3 => 'VAT', :numcode => '336'}, :as => :seed)
Country.create({:iso => 'HN', :printable_name => 'HONDURAS', :name => 'Honduras', :iso3 => 'HND', :numcode => '340'}, :as => :seed)
Country.create({:iso => 'HK', :printable_name => 'HONG KONG', :name => 'Hong Kong', :iso3 => 'HKG', :numcode => '344'}, :as => :seed)
Country.create({:iso => 'HU', :printable_name => 'HUNGARY', :name => 'Hungary', :iso3 => 'HUN', :numcode => '348'}, :as => :seed)
Country.create({:iso => 'IS', :printable_name => 'ICELAND', :name => 'Iceland', :iso3 => 'ISL', :numcode => '352'}, :as => :seed)
Country.create({:iso => 'IN', :printable_name => 'INDIA', :name => 'India', :iso3 => 'IND', :numcode => '356'}, :as => :seed)
Country.create({:iso => 'ID', :printable_name => 'INDONESIA', :name => 'Indonesia', :iso3 => 'IDN', :numcode => '360'}, :as => :seed)
Country.create({:iso => 'IR', :printable_name => 'IRAN, ISLAMIC REPUBLIC OF', :name => 'Iran, Islamic Republic of', :iso3 => 'IRN', :numcode => '364'}, :as => :seed)
Country.create({:iso => 'IQ', :printable_name => 'IRAQ', :name => 'Iraq', :iso3 => 'IRQ', :numcode => '368'}, :as => :seed)
Country.create({:iso => 'IE', :printable_name => 'IRELAND', :name => 'Ireland', :iso3 => 'IRL', :numcode => '372'}, :as => :seed)
Country.create({:iso => 'IL', :printable_name => 'ISRAEL', :name => 'Israel', :iso3 => 'ISR', :numcode => '376'}, :as => :seed)
Country.create({:iso => 'IT', :printable_name => 'ITALY', :name => 'Italy', :iso3 => 'ITA', :numcode => '380'}, :as => :seed)
Country.create({:iso => 'JM', :printable_name => 'JAMAICA', :name => 'Jamaica', :iso3 => 'JAM', :numcode => '388'}, :as => :seed)
Country.create({:iso => 'JP', :printable_name => 'JAPAN', :name => 'Japan', :iso3 => 'JPN', :numcode => '392'}, :as => :seed)
Country.create({:iso => 'JO', :printable_name => 'JORDAN', :name => 'Jordan', :iso3 => 'JOR', :numcode => '400'}, :as => :seed)
Country.create({:iso => 'KZ', :printable_name => 'KAZAKHSTAN', :name => 'Kazakhstan', :iso3 => 'KAZ', :numcode => '398'}, :as => :seed)
Country.create({:iso => 'KE', :printable_name => 'KENYA', :name => 'Kenya', :iso3 => 'KEN', :numcode => '404'}, :as => :seed)
Country.create({:iso => 'KI', :printable_name => 'KIRIBATI', :name => 'Kiribati', :iso3 => 'KIR', :numcode => '296'}, :as => :seed)
Country.create({:iso => 'KP', :printable_name => 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', :name => 'Korea, Democratic People\'s Republic of', :iso3 => 'PRK', :numcode => '408'}, :as => :seed)
Country.create({:iso => 'KR', :printable_name => 'KOREA, REPUBLIC OF', :name => 'Korea, Republic of', :iso3 => 'KOR', :numcode => '410'}, :as => :seed)
Country.create({:iso => 'KW', :printable_name => 'KUWAIT', :name => 'Kuwait', :iso3 => 'KWT', :numcode => '414'}, :as => :seed)
Country.create({:iso => 'KG', :printable_name => 'KYRGYZSTAN', :name => 'Kyrgyzstan', :iso3 => 'KGZ', :numcode => '417'}, :as => :seed)
Country.create({:iso => 'LA', :printable_name => 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', :name => 'Lao People\'s Democratic Republic', :iso3 => 'LAO', :numcode => '418'}, :as => :seed)
Country.create({:iso => 'LV', :printable_name => 'LATVIA', :name => 'Latvia', :iso3 => 'LVA', :numcode => '428'}, :as => :seed)
Country.create({:iso => 'LB', :printable_name => 'LEBANON', :name => 'Lebanon', :iso3 => 'LBN', :numcode => '422'}, :as => :seed)
Country.create({:iso => 'LS', :printable_name => 'LESOTHO', :name => 'Lesotho', :iso3 => 'LSO', :numcode => '426'}, :as => :seed)
Country.create({:iso => 'LR', :printable_name => 'LIBERIA', :name => 'Liberia', :iso3 => 'LBR', :numcode => '430'}, :as => :seed)
Country.create({:iso => 'LY', :printable_name => 'LIBYAN ARAB JAMAHIRIYA', :name => 'Libyan Arab Jamahiriya', :iso3 => 'LBY', :numcode => '434'}, :as => :seed)
Country.create({:iso => 'LI', :printable_name => 'LIECHTENSTEIN', :name => 'Liechtenstein', :iso3 => 'LIE', :numcode => '438'}, :as => :seed)
Country.create({:iso => 'LT', :printable_name => 'LITHUANIA', :name => 'Lithuania', :iso3 => 'LTU', :numcode => '440'}, :as => :seed)
Country.create({:iso => 'LU', :printable_name => 'LUXEMBOURG', :name => 'Luxembourg', :iso3 => 'LUX', :numcode => '442'}, :as => :seed)
Country.create({:iso => 'MO', :printable_name => 'MACAO', :name => 'Macao', :iso3 => 'MAC', :numcode => '446'}, :as => :seed)
Country.create({:iso => 'MK', :printable_name => 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', :name => 'Macedonia, the Former Yugoslav Republic of', :iso3 => 'MKD', :numcode => '807'}, :as => :seed)
Country.create({:iso => 'MG', :printable_name => 'MADAGASCAR', :name => 'Madagascar', :iso3 => 'MDG', :numcode => '450'}, :as => :seed)
Country.create({:iso => 'MW', :printable_name => 'MALAWI', :name => 'Malawi', :iso3 => 'MWI', :numcode => '454'}, :as => :seed)
Country.create({:iso => 'MY', :printable_name => 'MALAYSIA', :name => 'Malaysia', :iso3 => 'MYS', :numcode => '458'}, :as => :seed)
Country.create({:iso => 'MV', :printable_name => 'MALDIVES', :name => 'Maldives', :iso3 => 'MDV', :numcode => '462'}, :as => :seed)
Country.create({:iso => 'ML', :printable_name => 'MALI', :name => 'Mali', :iso3 => 'MLI', :numcode => '466'}, :as => :seed)
Country.create({:iso => 'MT', :printable_name => 'MALTA', :name => 'Malta', :iso3 => 'MLT', :numcode => '470'}, :as => :seed)
Country.create({:iso => 'MH', :printable_name => 'MARSHALL ISLANDS', :name => 'Marshall Islands', :iso3 => 'MHL', :numcode => '584'}, :as => :seed)
Country.create({:iso => 'MQ', :printable_name => 'MARTINIQUE', :name => 'Martinique', :iso3 => 'MTQ', :numcode => '474'}, :as => :seed)
Country.create({:iso => 'MR', :printable_name => 'MAURITANIA', :name => 'Mauritania', :iso3 => 'MRT', :numcode => '478'}, :as => :seed)
Country.create({:iso => 'MU', :printable_name => 'MAURITIUS', :name => 'Mauritius', :iso3 => 'MUS', :numcode => '480'}, :as => :seed)
Country.create({:iso => 'MX', :printable_name => 'MEXICO', :name => 'Mexico', :iso3 => 'MEX', :numcode => '484'}, :as => :seed)
Country.create({:iso => 'FM', :printable_name => 'MICRONESIA, FEDERATED STATES OF', :name => 'Micronesia, Federated States of', :iso3 => 'FSM', :numcode => '583'}, :as => :seed)
Country.create({:iso => 'MD', :printable_name => 'MOLDOVA, REPUBLIC OF', :name => 'Moldova, Republic of', :iso3 => 'MDA', :numcode => '498'}, :as => :seed)
Country.create({:iso => 'MC', :printable_name => 'MONACO', :name => 'Monaco', :iso3 => 'MCO', :numcode => '492'}, :as => :seed)
Country.create({:iso => 'MN', :printable_name => 'MONGOLIA', :name => 'Mongolia', :iso3 => 'MNG', :numcode => '496'}, :as => :seed)
Country.create({:iso => 'ME', :printable_name => 'MONTENEGRO', :name => 'Montenegro', :iso3 => 'MNE', :numcode => '499'}, :as => :seed)
Country.create({:iso => 'MS', :printable_name => 'MONTSERRAT', :name => 'Montserrat', :iso3 => 'MSR', :numcode => '500'}, :as => :seed)
Country.create({:iso => 'MA', :printable_name => 'MOROCCO', :name => 'Morocco', :iso3 => 'MAR', :numcode => '504'}, :as => :seed)
Country.create({:iso => 'MZ', :printable_name => 'MOZAMBIQUE', :name => 'Mozambique', :iso3 => 'MOZ', :numcode => '508'}, :as => :seed)
Country.create({:iso => 'MM', :printable_name => 'MYANMAR', :name => 'Myanmar', :iso3 => 'MMR', :numcode => '104'}, :as => :seed)
Country.create({:iso => 'NA', :printable_name => 'NAMIBIA', :name => 'Namibia', :iso3 => 'NAM', :numcode => '516'}, :as => :seed)
Country.create({:iso => 'NR', :printable_name => 'NAURU', :name => 'Nauru', :iso3 => 'NRU', :numcode => '520'}, :as => :seed)
Country.create({:iso => 'NP', :printable_name => 'NEPAL', :name => 'Nepal', :iso3 => 'NPL', :numcode => '524'}, :as => :seed)
Country.create({:iso => 'NL', :printable_name => 'NETHERLANDS', :name => 'Netherlands', :iso3 => 'NLD', :numcode => '528'}, :as => :seed)
Country.create({:iso => 'AN', :printable_name => 'NETHERLANDS ANTILLES', :name => 'Netherlands Antilles', :iso3 => 'ANT', :numcode => '530'}, :as => :seed)
Country.create({:iso => 'NC', :printable_name => 'NEW CALEDONIA', :name => 'New Caledonia', :iso3 => 'NCL', :numcode => '540'}, :as => :seed)
Country.create({:iso => 'NZ', :printable_name => 'NEW ZEALAND', :name => 'New Zealand', :iso3 => 'NZL', :numcode => '554'}, :as => :seed)
Country.create({:iso => 'NI', :printable_name => 'NICARAGUA', :name => 'Nicaragua', :iso3 => 'NIC', :numcode => '558'}, :as => :seed)
Country.create({:iso => 'NE', :printable_name => 'NIGER', :name => 'Niger', :iso3 => 'NER', :numcode => '562'}, :as => :seed)
Country.create({:iso => 'NG', :printable_name => 'NIGERIA', :name => 'Nigeria', :iso3 => 'NGA', :numcode => '566'}, :as => :seed)
Country.create({:iso => 'NU', :printable_name => 'NIUE', :name => 'Niue', :iso3 => 'NIU', :numcode => '570'}, :as => :seed)
Country.create({:iso => 'NF', :printable_name => 'NORFOLK ISLAND', :name => 'Norfolk Island', :iso3 => 'NFK', :numcode => '574'}, :as => :seed)
Country.create({:iso => 'MP', :printable_name => 'NORTHERN MARIANA ISLANDS', :name => 'Northern Mariana Islands', :iso3 => 'MNP', :numcode => '580'}, :as => :seed)
Country.create({:iso => 'NO', :printable_name => 'NORWAY', :name => 'Norway', :iso3 => 'NOR', :numcode => '578'}, :as => :seed)
Country.create({:iso => 'OM', :printable_name => 'OMAN', :name => 'Oman', :iso3 => 'OMN', :numcode => '512'}, :as => :seed)
Country.create({:iso => 'PK', :printable_name => 'PAKISTAN', :name => 'Pakistan', :iso3 => 'PAK', :numcode => '586'}, :as => :seed)
Country.create({:iso => 'PW', :printable_name => 'PALAU', :name => 'Palau', :iso3 => 'PLW', :numcode => '585'}, :as => :seed)
Country.create({:iso => 'PS', :printable_name => 'PALESTINIAN TERRITORY', :name => 'Palestinian Territory', :iso3 => 'PSE', :numcode => '275'}, :as => :seed)
Country.create({:iso => 'PA', :printable_name => 'PANAMA', :name => 'Panama', :iso3 => 'PAN', :numcode => '591'}, :as => :seed)
Country.create({:iso => 'PG', :printable_name => 'PAPUA NEW GUINEA', :name => 'Papua New Guinea', :iso3 => 'PNG', :numcode => '598'}, :as => :seed)
Country.create({:iso => 'PY', :printable_name => 'PARAGUAY', :name => 'Paraguay', :iso3 => 'PRY', :numcode => '600'}, :as => :seed)
Country.create({:iso => 'PE', :printable_name => 'PERU', :name => 'Peru', :iso3 => 'PER', :numcode => '604'}, :as => :seed)
Country.create({:iso => 'PH', :printable_name => 'PHILIPPINES', :name => 'Philippines', :iso3 => 'PHL', :numcode => '608'}, :as => :seed)
Country.create({:iso => 'PN', :printable_name => 'PITCAIRN', :name => 'Pitcairn', :iso3 => 'PCN', :numcode => '612'}, :as => :seed)
Country.create({:iso => 'PL', :printable_name => 'POLAND', :name => 'Poland', :iso3 => 'POL', :numcode => '616'}, :as => :seed)
Country.create({:iso => 'PT', :printable_name => 'PORTUGAL', :name => 'Portugal', :iso3 => 'PRT', :numcode => '620'}, :as => :seed)
Country.create({:iso => 'PR', :printable_name => 'PUERTO RICO', :name => 'Puerto Rico', :iso3 => 'PRI', :numcode => '630'}, :as => :seed)
Country.create({:iso => 'QA', :printable_name => 'QATAR', :name => 'Qatar', :iso3 => 'QAT', :numcode => '634'}, :as => :seed)
Country.create({:iso => 'RE', :printable_name => 'REUNION', :name => 'Reunion', :iso3 => 'REU', :numcode => '638'}, :as => :seed)
Country.create({:iso => 'RO', :printable_name => 'ROMANIA', :name => 'Romania', :iso3 => 'ROM', :numcode => '642'}, :as => :seed)
Country.create({:iso => 'RU', :printable_name => 'RUSSIAN FEDERATION', :name => 'Russian Federation', :iso3 => 'RUS', :numcode => '643'}, :as => :seed)
Country.create({:iso => 'RW', :printable_name => 'RWANDA', :name => 'Rwanda', :iso3 => 'RWA', :numcode => '646'}, :as => :seed)
Country.create({:iso => 'SH', :printable_name => 'SAINT HELENA', :name => 'Saint Helena', :iso3 => 'SHN', :numcode => '654'}, :as => :seed)
Country.create({:iso => 'KN', :printable_name => 'SAINT KITTS AND NEVIS', :name => 'Saint Kitts and Nevis', :iso3 => 'KNA', :numcode => '659'}, :as => :seed)
Country.create({:iso => 'LC', :printable_name => 'SAINT LUCIA', :name => 'Saint Lucia', :iso3 => 'LCA', :numcode => '662'}, :as => :seed)
Country.create({:iso => 'PM', :printable_name => 'SAINT PIERRE AND MIQUELON', :name => 'Saint Pierre and Miquelon', :iso3 => 'SPM', :numcode => '666'}, :as => :seed)
Country.create({:iso => 'VC', :printable_name => 'SAINT VINCENT AND THE GRENADINES', :name => 'Saint Vincent and the Grenadines', :iso3 => 'VCT', :numcode => '670'}, :as => :seed)
Country.create({:iso => 'WS', :printable_name => 'SAMOA', :name => 'Samoa', :iso3 => 'WSM', :numcode => '882'}, :as => :seed)
Country.create({:iso => 'SM', :printable_name => 'SAN MARINO', :name => 'San Marino', :iso3 => 'SMR', :numcode => '674'}, :as => :seed)
Country.create({:iso => 'ST', :printable_name => 'SAO TOME AND PRINCIPE', :name => 'Sao Tome and Principe', :iso3 => 'STP', :numcode => '678'}, :as => :seed)
Country.create({:iso => 'SA', :printable_name => 'SAUDI ARABIA', :name => 'Saudi Arabia', :iso3 => 'SAU', :numcode => '682'}, :as => :seed)
Country.create({:iso => 'SN', :printable_name => 'SENEGAL', :name => 'Senegal', :iso3 => 'SEN', :numcode => '686'}, :as => :seed)
Country.create({:iso => 'RS', :printable_name => 'SERBIA', :name => 'Serbia', :iso3 => 'SRB', :numcode => '688'}, :as => :seed)
Country.create({:iso => 'SC', :printable_name => 'SEYCHELLES', :name => 'Seychelles', :iso3 => 'SYC', :numcode => '690'}, :as => :seed)
Country.create({:iso => 'SL', :printable_name => 'SIERRA LEONE', :name => 'Sierra Leone', :iso3 => 'SLE', :numcode => '694'}, :as => :seed)
Country.create({:iso => 'SG', :printable_name => 'SINGAPORE', :name => 'Singapore', :iso3 => 'SGP', :numcode => '702'}, :as => :seed)
Country.create({:iso => 'SK', :printable_name => 'SLOVAKIA', :name => 'Slovakia', :iso3 => 'SVK', :numcode => '703'}, :as => :seed)
Country.create({:iso => 'SI', :printable_name => 'SLOVENIA', :name => 'Slovenia', :iso3 => 'SVN', :numcode => '705'}, :as => :seed)
Country.create({:iso => 'SB', :printable_name => 'SOLOMON ISLANDS', :name => 'Solomon Islands', :iso3 => 'SLB', :numcode => '090'}, :as => :seed)
Country.create({:iso => 'SO', :printable_name => 'SOMALIA', :name => 'Somalia', :iso3 => 'SOM', :numcode => '706'}, :as => :seed)
Country.create({:iso => 'ZA', :printable_name => 'SOUTH AFRICA', :name => 'South Africa', :iso3 => 'ZAF', :numcode => '710'}, :as => :seed)
Country.create({:iso => 'ES', :printable_name => 'SPAIN', :name => 'Spain', :iso3 => 'ESP', :numcode => '724'}, :as => :seed)
Country.create({:iso => 'LK', :printable_name => 'SRI LANKA', :name => 'Sri Lanka', :iso3 => 'LKA', :numcode => '144'}, :as => :seed)
Country.create({:iso => 'SD', :printable_name => 'SUDAN', :name => 'Sudan', :iso3 => 'SDN', :numcode => '736'}, :as => :seed)
Country.create({:iso => 'SR', :printable_name => 'SURINAME', :name => 'Suriname', :iso3 => 'SUR', :numcode => '740'}, :as => :seed)
Country.create({:iso => 'SJ', :printable_name => 'SVALBARD AND JAN MAYEN', :name => 'Svalbard and Jan Mayen', :iso3 => 'SJM', :numcode => '744'}, :as => :seed)
Country.create({:iso => 'SZ', :printable_name => 'SWAZILAND', :name => 'Swaziland', :iso3 => 'SWZ', :numcode => '748'}, :as => :seed)
Country.create({:iso => 'SE', :printable_name => 'SWEDEN', :name => 'Sweden', :iso3 => 'SWE', :numcode => '752'}, :as => :seed)
Country.create({:iso => 'CH', :printable_name => 'SWITZERLAND', :name => 'Switzerland', :iso3 => 'CHE', :numcode => '756'}, :as => :seed)
Country.create({:iso => 'SY', :printable_name => 'SYRIAN ARAB REPUBLIC', :name => 'Syrian Arab Republic', :iso3 => 'SYR', :numcode => '760'}, :as => :seed)
Country.create({:iso => 'TW', :printable_name => 'TAIWAN, PROVINCE OF CHINA', :name => 'Taiwan, Province of China', :iso3 => 'TWN', :numcode => '158'}, :as => :seed)
Country.create({:iso => 'TJ', :printable_name => 'TAJIKISTAN', :name => 'Tajikistan', :iso3 => 'TJK', :numcode => '762'}, :as => :seed)
Country.create({:iso => 'TZ', :printable_name => 'TANZANIA, UNITED REPUBLIC OF', :name => 'Tanzania, United Republic of', :iso3 => 'TZA', :numcode => '834'}, :as => :seed)
Country.create({:iso => 'TH', :printable_name => 'THAILAND', :name => 'Thailand', :iso3 => 'THA', :numcode => '764'}, :as => :seed)
Country.create({:iso => 'TL', :printable_name => 'TIMOR-LESTE', :name => 'Timor-Leste', :iso3 => 'TLS', :numcode => '626'}, :as => :seed)
Country.create({:iso => 'TG', :printable_name => 'TOGO', :name => 'Togo', :iso3 => 'TGO', :numcode => '768'}, :as => :seed)
Country.create({:iso => 'TK', :printable_name => 'TOKELAU', :name => 'Tokelau', :iso3 => 'TKL', :numcode => '772'}, :as => :seed)
Country.create({:iso => 'TO', :printable_name => 'TONGA', :name => 'Tonga', :iso3 => 'TON', :numcode => '776'}, :as => :seed)
Country.create({:iso => 'TT', :printable_name => 'TRINIDAD AND TOBAGO', :name => 'Trinidad and Tobago', :iso3 => 'TTO', :numcode => '780'}, :as => :seed)
Country.create({:iso => 'TN', :printable_name => 'TUNISIA', :name => 'Tunisia', :iso3 => 'TUN', :numcode => '788'}, :as => :seed)
Country.create({:iso => 'TR', :printable_name => 'TURKEY', :name => 'Turkey', :iso3 => 'TUR', :numcode => '792'}, :as => :seed)
Country.create({:iso => 'TM', :printable_name => 'TURKMENISTAN', :name => 'Turkmenistan', :iso3 => 'TKM', :numcode => '795'}, :as => :seed)
Country.create({:iso => 'TC', :printable_name => 'TURKS AND CAICOS ISLANDS', :name => 'Turks and Caicos Islands', :iso3 => 'TCA', :numcode => '796'}, :as => :seed)
Country.create({:iso => 'TV', :printable_name => 'TUVALU', :name => 'Tuvalu', :iso3 => 'TUV', :numcode => '798'}, :as => :seed)
Country.create({:iso => 'UG', :printable_name => 'UGANDA', :name => 'Uganda', :iso3 => 'UGA', :numcode => '800'}, :as => :seed)
Country.create({:iso => 'UA', :printable_name => 'UKRAINE', :name => 'Ukraine', :iso3 => 'UKR', :numcode => '804'}, :as => :seed)
Country.create({:iso => 'AE', :printable_name => 'UNITED ARAB EMIRATES', :name => 'United Arab Emirates', :iso3 => 'ARE', :numcode => '784'}, :as => :seed)
Country.create({:iso => 'GB', :printable_name => 'UNITED KINGDOM', :name => 'United Kingdom', :iso3 => 'GBR', :numcode => '826'}, :as => :seed)
Country.create({:iso => 'US', :printable_name => 'UNITED STATES', :name => 'United States', :iso3 => 'USA', :numcode => '840'}, :as => :seed)
Country.create({:iso => 'UY', :printable_name => 'URUGUAY', :name => 'Uruguay', :iso3 => 'URY', :numcode => '858'}, :as => :seed)
Country.create({:iso => 'UZ', :printable_name => 'UZBEKISTAN', :name => 'Uzbekistan', :iso3 => 'UZB', :numcode => '860'}, :as => :seed)
Country.create({:iso => 'VU', :printable_name => 'VANUATU', :name => 'Vanuatu', :iso3 => 'VUT', :numcode => '548'}, :as => :seed)
Country.create({:iso => 'VE', :printable_name => 'VENEZUELA', :name => 'Venezuela', :iso3 => 'VEN', :numcode => '862'}, :as => :seed)
Country.create({:iso => 'VN', :printable_name => 'VIET NAM', :name => 'Viet Nam', :iso3 => 'VNM', :numcode => '704'}, :as => :seed)
Country.create({:iso => 'VG', :printable_name => 'VIRGIN ISLANDS, BRITISH', :name => 'Virgin Islands, British', :iso3 => 'VGB', :numcode => '092'}, :as => :seed)
Country.create({:iso => 'VI', :printable_name => 'VIRGIN ISLANDS, U.S.', :name => 'Virgin Islands, U.s.', :iso3 => 'VIR', :numcode => '850'}, :as => :seed)
Country.create({:iso => 'WF', :printable_name => 'WALLIS AND FUTUNA', :name => 'Wallis and Futuna', :iso3 => 'WLF', :numcode => '876'}, :as => :seed)
Country.create({:iso => 'EH', :printable_name => 'WESTERN SAHARA', :name => 'Western Sahara', :iso3 => 'ESH', :numcode => '732'}, :as => :seed)
Country.create({:iso => 'YE', :printable_name => 'YEMEN', :name => 'Yemen', :iso3 => 'YEM', :numcode => '887'}, :as => :seed)
Country.create({:iso => 'ZM', :printable_name => 'ZAMBIA', :name => 'Zambia', :iso3 => 'ZMB', :numcode => '894'}, :as => :seed)
Country.create({:iso => 'ZW', :printable_name => 'ZIMBABWE', :name => 'Zimbabwe', :iso3 => 'ZWE', :numcode => '716'}, :as => :seed)
puts "Seeding Done!"
