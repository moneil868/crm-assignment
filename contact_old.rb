gem 'activerecord', '=4.2.7'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact

  @@contacts = []
  @@id = 1

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note

    @id = @@id
    @@id += 1
  end

  #READERS

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def email
    @email
  end

  def note
    @note
  end

  def id
    @id
  end

  #WRITERS

  def first_name=(first_name)
    @first_name = first_name
  end

  def last_name=(last_name)
    @last_name = last_name
  end

  def email=(email)
    @email = email
  end


  def note=(note)
    @note = note
  end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    new_contact = Contact.new(first_name, last_name, email, note)
    @@contacts << new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    puts "Finding the contact with ID ##{id}..."
    @@contacts.find do |contact|
      if contact.id == id
        puts "#{ contact.full_name } is ID number #{ contact.id } in the contacts array"
      end
    end
  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def self.update=(attribute)
    found = Contact.find_by(attribute)
    print "Please enter the new '#{attribute}' for the '#{found.full_name}': "
    value = gets.chomp
    found.send(attribute)
    binding.pry
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute)
    print "Please enter the #{ attribute } for the user you wish to find:  "
    @value = gets.chomp
    @@contacts.find { |contact| contact.send(attribute) == @value }
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts.clear
  end

  def full_name
    return "#{ @first_name } #{ @last_name }"
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def self.delete(contact)
      @@contacts.delete(contact)
  end

  # Feel free to add other methods here, if you need them.

end
