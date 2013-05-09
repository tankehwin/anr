class Country < ActiveRecord::Base
  attr_readonly :iso, :iso3, :name, :numcode, :printable_name
  attr_accessible :iso, :iso3, :name, :numcode, :printable_name, :as => :seed

  has_many :players
  
  def self.malaysia_id
    @malaysia_id ||= find_by_name("Malaysia").id
  end
  
  def self.singapore_id
    @singapore_id ||= find_by_name("Singapore").id
  end
  
  def self.malaysia_iso
    @malaysia_iso ||= find_by_name("Malaysia").iso
  end
  
  def self.singapore_iso
    @singapore_iso ||= find_by_name("Singapore").iso
  end
  
  def afghanistan?
    @isAfghanistan ||= (self.name == "Afghanistan")? true : false
  end
  
  def albania?
    @isAlbania ||= (self.name == "Albania")? true : false
  end
  
  def algeria?
    @isAlgeria ||= (self.name == "Algeria")? true : false
  end
  
  def american_samoa?
    @isAmericanSamoa ||= (self.name == "American Samoa")? true : false
  end
  
  def andorra?
    @isAndorra ||= (self.name == "Andorra")? true : false
  end
  
  def angola?
    @isAngola ||= (self.name == "Angola")? true : false
  end
  
  def anguilla?
    @isAnguilla ||= (self.name == "Anguilla")? true : false
  end
  
  def antigua_and_barbuda?
    @isAntiguaAndBarbuda ||= (self.name == "Antigua and Barbuda")? true : false
  end
  
  def argentina?
    @isArgentina ||= (self.name == "Argentina")? true : false
  end
  
  def armenia?
    @isArmenia ||= (self.name == "Armenia")? true : false
  end
  
  def aruba?
    @isAruba ||= (self.name == "Aruba")? true : false
  end
  
  def australia?
    @isAustralia ||= (self.name == "Australia")? true : false
  end
  
  def austria?
    @isAustria ||= (self.name == "Austria")? true : false
  end
  
  def azerbaijan?
    @isAzerbaijan ||= (self.name == "Azerbaijan")? true : false
  end
  
  def bahamas?
    @isBahamas ||= (self.name == "Bahamas")? true : false
  end
  
  def bahrain?
    @isBahrain ||= (self.name == "Bahrain")? true : false
  end
  
  def bangladesh?
    @isBangladesh ||= (self.name == "Bangladesh")? true : false
  end
  
  def barbados?
    @isBarbados ||= (self.name == "Barbados")? true : false
  end
  
  def belarus?
    @isBelarus ||= (self.name == "Belarus")? true : false
  end
  
  def belgium?
    @isBelgium ||= (self.name == "Belgium")? true : false
  end
  
  def belize?
    @isBelize ||= (self.name == "Belize")? true : false
  end
  
  def benin?
    @isBenin ||= (self.name == "Benin")? true : false
  end
  
  def bermuda?
    @isBermuda ||= (self.name == "Bermuda")? true : false
  end
  
  def bhutan?
    @isBhutan ||= (self.name == "Bhutan")? true : false
  end
  
  def bolivia?
    @isBolivia ||= (self.name == "Bolivia")? true : false
  end
  
  def bosnia_and_herzegovina?
    @isBosniaAndHerzegovina ||= (self.name == "Bosnia and Herzegovina")? true : false
  end
  
  def botswana?
    @isBotswana ||= (self.name == "Botswana")? true : false
  end
  
  def brazil?
    @isBrazil ||= (self.name == "Brazil")? true : false
  end
  
  def brunei?
    @isBrunei ||= (self.name == "Brunei Darussalam")? true : false
  end
  
  def bulgaria?
    @isBulgaria ||= (self.name == "Bulgaria")? true : false
  end
  
  def burkina_faso?
    @isBurkinaFaso ||= (self.name == "Burkina Faso")? true : false
  end
  
  def burundi?
    @isBurundi ||= (self.name == "Burundi")? true : false
  end
  
  def cambodia?
    @isCambodia ||= (self.name == "Cambodia")? true : false
  end
  
  def cameroon?
    @isCmeroon ||= (self.name == "Cameroon")? true : false
  end
  
  def canada?
    @isCanada ||= (self.name == "Canada")? true : false
  end
  
  def cape_verde?
    @isCapeVerde ||= (self.name == "Cape Verde")? true : false
  end
  
  def cayman_islands?
    @isCaymanIslands ||= (self.name == "Cayman Islands")? true : false
  end
  
  def central_african_republic?
    @isCentralAfricanRepublic ||= (self.name == "Central African Republic")? true : false
  end
  
  def chad?
    @isChad ||= (self.name == "Chad")? true : false
  end
  
  def chile?
    @isChile ||= (self.name == "Chile")? true : false
  end
  
  def china?
    @isChina ||= (self.name == "China")? true : false
  end
  
  def colombia?
    @isColombia ||= (self.name == "Colombia")? true : false
  end
  
  def comoros?
    @isComoros ||= (self.name == "Comoros")? true : false
  end
  
  def republic_of_congo?
    @isRepublicOfCongo ||= (self.name == "Congo")? true : false
  end
  
  def democratic_republic_of_congo?
    @isDemocraticRepublicOfCongo ||= (self.name == "Congo, the Democratic Republic of the")? true : false
  end
  
  def cook_islands?
    @isCookIslands ||= (self.name == "Cook Islands")? true : false
  end
  
  def costa_rica?
    @isCostaRica ||= (self.name == "Costa Rica")? true : false
  end
  
  def ivory_coast?
    @isIvoryCoast ||= (self.name == "Cote D\'Ivoire")? true : false
  end
  
  def croatia?
    @isCroatia ||= (self.name == "Croatia")? true : false
  end
  
  def cuba?
    @isCuba ||= (self.name == "Cuba")? true : false
  end
  
  def cyprus?
    @isCyprus ||= (self.name == "Cyprus")? true : false
  end
  
  def czech_republic?
    @isCzechRepublic ||= (self.name == "Czech Republic")? true : false
  end
  
  def denmark?
    @isDenmark ||= (self.name == "Denmark")? true : false
  end
  
  def djibouti?
    @isDjibouti ||= (self.name == "Djibouti")? true : false
  end
  
  def dominica?
    @isDominica ||= (self.name == "Dominica")? true : false
  end
  
  def dominican_republic?
    @isDominicanRepublic ||= (self.name == "Dominican Republic")? true : false
  end
  
  def east_timor?
    @isEastTimor ||= (self.name == "Timor-Leste")? true : false
  end
  
  def ecuador?
    @isEcuador ||= (self.name == "Ecuador")? true : false
  end
  
  def egypt?
    @isEgypt ||= (self.name == "Egypt")? true : false
  end
  
  def el_salvador?
    @isElSalvador ||= (self.name == "El Salvador")? true : false
  end
  
  def equatorial_guinea?
    @isEquatorialGuinea ||= (self.name == "Equatorial Guinea")? true : false
  end
  
  def eritrea?
    @isEritrea ||= (self.name == "Eritrea")? true : false
  end
  
  def estonia?
    @isEstonia ||= (self.name == "Estonia")? true : false
  end
  
  def ethiopia?
    @isEthiopia ||= (self.name == "Ethiopia")? true : false
  end
  
  def falkland_islands?
    @isFalklandIslands ||= (self.name == "Falkland Islands (Malvinas")? true : false
  end
  
  def faroe_islands?
    @isFaroeIslands ||= (self.name == "Faroe Islands")? true : false
  end
  
  def fiji?
    @isFiji ||= (self.name == "Fiji")? true : false
  end
  
  def finland?
    @isFinland ||= (self.name == "Finland")? true : false
  end
  
  def france?
    @isFrance ||= (self.name == "France")? true : false
  end
  
  def french_guiana?
    @isFrenchGuiana ||= (self.name == "French Guiana")? true : false
  end
  
  def french_polynesia?
    @isFrenchPolynesia ||= (self.name == "French Polynesia")? true : false
  end
  
  def gabon?
    @isGabon ||= (self.name == "Gabon")? true : false
  end
  
  def gambia?
    @isGambia ||= (self.name == "Gambia")? true : false
  end
  
  def georgia?
    @isGeorgia ||= (self.name == "Georgia")? true : false
  end
  
  def germany?
    @isGermany ||= (self.name == "Germany")? true : false
  end
  
  def ghana?
    @isGhana ||= (self.name == "Ghana")? true : false
  end
  
  def gibraltar?
    @isGibraltar ||= (self.name == "Gibraltar")? true : false
  end
  
  def greece?
    @isGreece ||= (self.name == "Greece")? true : false
  end
  
  def greenland?
    @isGreenland ||= (self.name == "Greenland")? true : false
  end
  
  def grenada?
    @isGrenada ||= (self.name == "Grenada")? true : false
  end
  
  def guadeloupe?
    @isGuadeloupe ||= (self.name == "Guadeloupe")? true : false
  end
  
  def guam?
    @isGuam ||= (self.name == "Guam")? true : false
  end
  
  def guatemala?
    @isGuatemala ||= (self.name == "Guatemala")? true : false
  end
  
  def guinea?
    @isGuinea ||= (self.name == "Guinea")? true : false
  end
  
  def guinea_bissau?
    @isGuineaBissau ||= (self.name == "Guinea-Bissau")? true : false
  end
  
  def guyana?
    @isGuyana ||= (self.name == "Guyana")? true : false
  end
  
  def haiti?
    @isHaiti ||= (self.name == "Haiti")? true : false
  end
  
  def holy_see?
    @isHolySee ||= (self.name == "Holy See (Vatican City State")? true : false
  end
  
  def honduras?
    @isHonduras ||= (self.name == "Honduras")? true : false
  end
  
  def hong_kong?
    @isHongKong ||= (self.name == "Hong Kong")? true : false
  end
  
  def hungary?
    @isHungary ||= (self.name == "Hungary")? true : false
  end
  
  def iceland?
    @isIceland ||= (self.name == "Iceland")? true : false
  end
  
  def india?
    @isIndia ||= (self.name == "India")? true : false
  end
  
  def indonesia?
    @isIndonesia ||= (self.name == "Indonesia")? true : false
  end
  
  def iran?
    @isIran ||= (self.name == "Iran, Islamic Republic of")? true : false
  end
  
  def iraq?
    @isIraq ||= (self.name == "Iraq")? true : false
  end
  
  def ireland?
    @isIreland ||= (self.name == "Ireland")? true : false
  end
  
  def israel?
    @isIsrael ||= (self.name == "Israel")? true : false
  end
  
  def italy?
    @isItaly ||= (self.name == "Italy")? true : false
  end
  
  def jamaica?
    @isJamaica ||= (self.name == "Jamaica")? true : false
  end
  
  def japan?
    @isJapan ||= (self.name == "Japan")? true : false
  end
  
  def jordan?
    @isJordan ||= (self.name == "Jordan")? true : false
  end
  
  def kazakhstan?
    @isKazakhstan ||= (self.name == "Kazakhstan")? true : false
  end
  
  def kenya?
    @isKenya ||= (self.name == "Kenya")? true : false
  end
  
  def kiribati?
    @isKiribati ||= (self.name == "Kiribati")? true : false
  end
  
  def north_korea?
    @isNorthKorea ||= (self.name == "Korea, Democratic People\'s Republic of")? true : false
  end
  
  def south_korea?
    @isSouthKorea ||= (self.name == "Korea, Republic of")? true : false
  end
  
  def kuwait?
    @isKuwait ||= (self.name == "Kuwait")? true : false
  end
  
  def kyrgyzstan?
    @isKyrgyzstan ||= (self.name == "Kyrgyzstan")? true : false
  end
  
  def laos?
    @isLaos ||= (self.name == "Lao People\'s Democratic Republic")? true : false
  end
  
  def latvia?
    @isLatvia ||= (self.name == "Latvia")? true : false
  end
  
  def lebanon?
    @isLebanon ||= (self.name == "Lebanon")? true : false
  end
  
  def lesotho?
    @isLesotho ||= (self.name == "Lesotho")? true : false
  end
  
  def liberia?
    @isLiberia ||= (self.name == "Liberia")? true : false
  end
  
  def libya?
    @isLibya ||= (self.name == "Libyan Arab Jamahiriya")? true : false
  end
  
  def liechtenstein?
    @isLiechtenstein ||= (self.name == "Liechtenstein")? true : false
  end
  
  def lithuania?
    @isLithuania ||= (self.name == "Lithuania")? true : false
  end
  
  def luxembourg?
    @isLuxembourg ||= (self.name == "Luxembourg")? true : false
  end
  
  def macau?
    @isMacau ||= (self.name == "Macao")? true : false
  end
  
  def macedonia?
    @isMacedonia ||= (self.name == "Macedonia, the Former Yugoslav Republic of")? true : false
  end
  
  def madagascar?
    @isMadagascar ||= (self.name == "Madagascar")? true : false
  end
  
  def malawi?
    @isMalawi ||= (self.name == "Malawi")? true : false
  end
  
  def malaysia?
    @isMalaysia ||= (self.name == "Malaysia")? true : false
  end
  
  def maldives?
    @isMaldives ||= (self.name == "Maldives")? true : false
  end
  
  def mali?
    @isMali ||= (self.name == "Mali")? true : false
  end
  
  def malta?
    @isMalta ||= (self.name == "Malta")? true : false
  end
  
  def marshall_islands?
    @isMarshallIslands ||= (self.name == "Marshall Islands")? true : false
  end
  
  def martinique?
    @isMartinique ||= (self.name == "Martinique")? true : false
  end
  
  def mauritania?
    @isMauritania ||= (self.name == "Mauritania")? true : false
  end
  
  def mauritius?
    @isMauritius ||= (self.name == "Mauritius")? true : false
  end
  
  def mexico?
    @isMexico ||= (self.name == "Mexico")? true : false
  end
  
  def micronesia?
    @isMicronesia ||= (self.name == "Micronesia, Federated States of")? true : false
  end
  
  def moldova?
    @isMoldova ||= (self.name == "Moldova, Republic of")? true : false
  end
  
  def monaco?
    @isMonaco ||= (self.name == "Monaco")? true : false
  end
  
  def montenegro?
    @isMontenegro ||= (self.name == "Montenegro")? true : false
  end
  
  def mongolia?
    @isMongolia ||= (self.name == "Mongolia")? true : false
  end
  
  def montserrat?
    @isMontserrat ||= (self.name == "Montserrat")? true : false
  end
  
  def morocco?
    @isMorocco ||= (self.name == "Morocco")? true : false
  end
  
  def mozambique?
    @isMozambique ||= (self.name == "Mozambique")? true : false
  end
  
  def myanmar?
    @isMyanmar ||= (self.name == "Myanmar")? true : false
  end
  
  def namibia?
    @isNamibia ||= (self.name == "Namibia")? true : false
  end
  
  def nauru?
    @isNauru ||= (self.name == "Nauru")? true : false
  end
  
  def nepal?
    @isNepal ||= (self.name == "Nepal")? true : false
  end
  
  def netherlands?
    @isNetherlands ||= (self.name == "Netherlands")? true : false
  end
  
  def netherlands_antilles?
    @isNetherlandsAntilles ||= (self.name == "Netherlands Antilles")? true : false
  end
  
  def new_caledonia?
    @isNewCaledonia ||= (self.name == "New Caledonia")? true : false
  end
  
  def new_zealand?
    @isNewZealand ||= (self.name == "New Zealand")? true : false
  end
  
  def nicaragua?
    @isNicaragua ||= (self.name == "Nicaragua")? true : false
  end
  
  def niger?
    @isNiger ||= (self.name == "Niger")? true : false
  end
  
  def nigeria?
    @isNigeria ||= (self.name == "Nigeria")? true : false
  end
  
  def niue?
    @isNiue ||= (self.name == "Niue")? true : false
  end
  
  def norfolk_island?
    @isNorfolkIsland ||= (self.name == "Norfolk Island")? true : false
  end
  
  def northern_mariana_islands?
    @isNorthernMarianaIslands ||= (self.name == "Northern Mariana Islands")? true : false
  end
  
  def norway?
    @isNorway ||= (self.name == "Norway")? true : false
  end
  
  def oman?
    @isOman ||= (self.name == "Oman")? true : false
  end
  
  def pakistan?
    @isPakistan ||= (self.name == "Pakistan")? true : false
  end
  
  def palau?
    @isPalau ||= (self.name == "Palau")? true : false
  end
  
  def palestine?
    @isPalestine ||= (self.name == "Palestinian Territory")? true : false
  end
  
  def panama?
    @isPanama ||= (self.name == "Panama")? true : false
  end
  
  def papua_new_guinea?
    @isPapuaNewGuinea ||= (self.name == "Papua New Guinea")? true : false
  end
  
  def paraguay?
    @isParaguay ||= (self.name == "Paraguay")? true : false
  end
  
  def peru?
    @isPeru ||= (self.name == "Peru")? true : false
  end
  
  def philippines?
    @isPhilippines ||= (self.name == "Philippines")? true : false
  end
  
  def pitcairn?
    @isPitcairn ||= (self.name == "Pitcairn")? true : false
  end
  
  def poland?
    @isPoland ||= (self.name == "Poland")? true : false
  end
  
  def portugal?
    @isPortugal ||= (self.name == "Portugal")? true : false
  end
  
  def puerto_rico?
    @isPuertoRico ||= (self.name == "Puerto Rico")? true : false
  end
  
  def qatar?
    @isQatar ||= (self.name == "Qatar")? true : false
  end
  
  def reunion?
    @isReunion ||= (self.name == "Reunion")? true : false
  end
  
  def romania?
    @isRomania ||= (self.name == "Romania")? true : false
  end
  
  def russia?
    @isRussia ||= (self.name == "Russian Federation")? true : false
  end
  
  def rwanda?
    @isRwanda ||= (self.name == "Rwanda")? true : false
  end
  
  def saint_helena?
    @isSaintHelena ||= (self.name == "Saint Helena")? true : false
  end
  
  def saint_kitts_and_nevis?
    @isSaintKittsAndNevis ||= (self.name == "Saint Kitts and Nevis")? true : false
  end
  
  def saint_lucia?
    @isSaintLucia ||= (self.name == "Saint Lucia")? true : false
  end
  
  def saint_pierre_and_miquelon?
    @isSaintPierreAndMiquelon ||= (self.name == "Saint Pierre and Miquelon")? true : false
  end
  
  def saint_vincent_and_the_grenadines?
    @isSaintVincentAndTheGrenadines ||= (self.name == "Saint Vincent and the Grenadines")? true : false
  end
  
  def samoa?
    @isSamoa ||= (self.name == "Samoa")? true : false
  end
  
  def san_marino?
    @isSanMarino ||= (self.name == "San Marino")? true : false
  end
  
  def sao_tome_and_principe?
    @isSaoTomeAndPrincipe ||= (self.name == "Sao Tome and Principe")? true : false
  end
  
  def saudi_arabia?
    @isSaudiArabia ||= (self.name == "Saudi Arabia")? true : false
  end
  
  def senegal?
    @isSenegal ||= (self.name == "Senegal")? true : false
  end
  
  def serbia?
    @isSerbia ||= (self.name == "Serbia")? true : false
  end
  
  def seychelles?
    @isSeychelles ||= (self.name == "Seychelles")? true : false
  end
  
  def sierra_leone?
    @isSierraLeone ||= (self.name == "Sierra Leone")? true : false
  end
  
  def singapore?
    @isSingapore ||= (self.name == "Singapore")? true : false
  end
  
  def slovakia?
    @isSlovakia ||= (self.name == "Slovakia")? true : false
  end
  
  def slovenia?
    @isSlovenia ||= (self.name == "Slovenia")? true : false
  end
  
  def solomon_islands?
    @isSolomonIslands ||= (self.name == "Solomon Islands")? true : false
  end
  
  def somalia?
    @isSomalia ||= (self.name == "Somalia")? true : false
  end
  
  def south_africa?
    @isSouthAfrica ||= (self.name == "South Africa")? true : false
  end
  
  def spain?
    @isSpain ||= (self.name == "Spain")? true : false
  end
  
  def sri_lanka?
    @isSriLanka ||= (self.name == "Sri Lanka")? true : false
  end
  
  def sudan?
    @isSudan ||= (self.name == "Sudan")? true : false
  end
  
  def suriname?
    @isSuriname ||= (self.name == "Suriname")? true : false
  end
  
  def svalbard_and_jan_mayen?
    @isSvalbardAndJanMayen ||= (self.name == "Svalbard and Jan Mayen")? true : false
  end
  
  def swaziland?
    @isSwaziland ||= (self.name == "Swaziland")? true : false
  end
  
  def sweden?
    @isSweden ||= (self.name == "Sweden")? true : false
  end
  
  def switzerland?
    @isSwitzerland ||= (self.name == "Switzerland")? true : false
  end
  
  def syria?
    @isSyria ||= (self.name == "Syrian Arab Republic")? true : false
  end
  
  def taiwan?
    @isTaiwan ||= (self.name == "Taiwan, Province of China")? true : false
  end
  
  def tajikistan?
    @isTajikistan ||= (self.name == "Tajikistan")? true : false
  end
  
  def tanzania?
    @isTanzania ||= (self.name == "Tanzania, United Republic of")? true : false
  end
  
  def thailand?
    @isThailand ||= (self.name == "Thailand")? true : false
  end
  
  def togo?
    @isTogo ||= (self.name == "Togo")? true : false
  end
  
  def tokelau?
    @isTokelau ||= (self.name == "Tokelau")? true : false
  end
  
  def tonga?
    @isTonga ||= (self.name == "Tonga")? true : false
  end
  
  def trinidad_and_tobago?
    @isTrinidadAndTobago ||= (self.name == "Trinidad and Tobago")? true : false
  end
  
  def tunisia?
    @isTunisia ||= (self.name == "Tunisia")? true : false
  end
  
  def turkey?
    @isTurkey ||= (self.name == "Turkey")? true : false
  end
  
  def turkmenistan?
    @isTurkmenistan ||= (self.name == "Turkmenistan")? true : false
  end
  
  def turks_and_caicos_islands?
    @isTurksAndCaicosIslands ||= (self.name == "Turks and Caicos Islands")? true : false
  end
  
  def tuvalu?
    @isTuvalu ||= (self.name == "Tuvalu")? true : false
  end
  
  def uganda?
    @isUganda ||= (self.name == "Uganda")? true : false
  end
  
  def ukraine?
    @isUkraine ||= (self.name == "Ukraine")? true : false
  end
  
  def united_arab_emirates?
    @isUnitedArabEmirates ||= (self.name == "United Arab Emirates")? true : false
  end
  
  def united_kingdom?
    @isUnitedKingdom ||= (self.name == "United Kingdom")? true : false
  end
  
  def united_states?
    @isUnitedStates ||= (self.name == "United States")? true : false
  end
  
  def uruguay?
    @isUruguay ||= (self.name == "Uruguay")? true : false
  end
  
  def uzbekistan?
    @isUzbekistan ||= (self.name == "Uzbekistan")? true : false
  end
  
  def vanuatu?
    @isVanuatu ||= (self.name == "Vanuatu")? true : false
  end
  
  def venezuela?
    @isVenezuela ||= (self.name == "Venezuela")? true : false
  end
  
  def vietnam?
    @isVietnam ||= (self.name == "Viet Nam")? true : false
  end
  
  def british_virgin_islands?
    @isBritishVirginIslands ||= (self.name == "Virgin Islands, British")? true : false
  end
  
  def us_virgin_islands?
    @isUsVirginIslands ||= (self.name == "Virgin Islands, U.s.")? true : false
  end
  
  def wallis_and_futuna?
    @isWallisAndFutuna ||= (self.name == "Wallis and Futuna")? true : false
  end
  
  def western_sahara?
    @isWesternSahara ||= (self.name == "Western Sahara")? true : false
  end
  
  def yemen?
    @isYemen ||= (self.name == "Yemen")? true : false
  end
  
  def zambia?
    @isZambia ||= (self.name == "Zambia")? true : false
  end
  
  def zimbabwe?
    @isZimbabwe ||= (self.name == "Zimbabwe")? true : false
  end
end
