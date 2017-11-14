require('pp')
require('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new(
{
'name' => 'Jabba The Hutt',
'bounty_value' => '120',
'homeworld' => 'Tatooine',
'cashed_in' => 'false'
}
)

bounty2 = Bounty.new(
{
'name' => 'Boba Fett',
'bounty_value' => '6',
'homeworld' => 'Kamino',
'cashed_in' => 'true'
}
)
# Bounty.delete_all

# bounty1.save
# bounty2.save
#
# bounty2.name = "Jango Fett"
#
# bounty2.update
# pp Bounty.all

pp Bounty.find(40)


binding.pry
nil
