require 'mail'
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    begin
      raise if value.empty?
      m = Mail::Address.new(value)
      # We must check that value contains a domain and that value is an email address
      valid = m.domain && m.address == value
      t = m.__send__(:tree)
      # We need to dig into treetop
      # A valid domain must have dot_atom_text elements size > 1
      # user@localhost is excluded
      # treetop must respond to domain
      # We exclude valid email values like <user@localhost.com>
      # Hence we use m.__send__(tree).domain
      valid &&= (t.domain.dot_atom_text.elements.size > 1)
    rescue Exception => e 
      valid = false
    end
    if not valid
      record.errors.clear
      record.errors[""] = "Please enter a valid email address."
    end
  end
end