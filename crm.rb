require_relative 'contact'
require 'pry'

class CRM

  def initialize(name)
    @name = name
  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    system("clear")
    puts "----------------------------------------------------"
    puts "Welcome, please select one of the following options"
    puts "----------------------------------------------------"
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts "----------------------------------------------------"
    print 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit
    end
  end

  def add_new_contact
    system("clear")
    puts "------------------------"
    puts "Add a new Contact"
    puts "-------------------------"
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    new_contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )
    puts

    puts "Adding new user..."
    sleep(1)
    puts "-------------------------------------------------------------------------"
    puts "Congratulations you have successfull added a new contact: '#{first_name} #{last_name}'."
    puts "-------------------------------------------------------------------------"
    print "Press any key to continue"
    gets.chomp
  end

  def modify_existing_contact
    system("clear")
      puts "----------------------------------------------------"
      puts "Modify Existing Contact"
      puts "----------------------------------------------------"
      puts
      puts "First, you need to find the contact you wish to edit."
      puts "Press any key to continue.."
      gets.chomp
      system("clear")
      result = search_by_attribute
      system("clear")
      update_menu
      user_selected = gets.to_i
      update_option(result, user_selected)
  end

  def update_menu
    puts
    puts "What contact attribute would you like to update? "
    puts "----------------------------------------------------"
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] Email Address'
    puts '[4] Notes'
    puts '[5] Go Back to Main Menu'
    puts "----------------------------------------------------"
    print 'Enter a number: '
  end

  def update_option(result, user_selected)
       puts "Enter value to update"
       value = gets.chomp
      case user_selected
      when 1 then result.update(first_name: value)
      when 2 then result.update(last_name: value)
      when 3 then result.update(email: value)
      when 4 then result.update(note: value)
      when 5 then main_menu
      end
  end




  def delete_contact
    system("clear")
    puts "----------------------------------------------------"
    puts "Delete a contact"
    puts "----------------------------------------------------"
    first_name = "first_name"
    print "Please enter the #{first_name} of the contact you wish to delete: "
    value = gets.chomp
    contact_to_delete = Contact.find_by(first_name => value)
    if contact_to_delete == nil
      puts
      puts "Sorry this contact does not exist, it may have already been deleted"
      puts "-------------------------------------------------------------------------"
      print "Press any key to continue"
      gets.chomp
    else
      puts
      puts "Deleting user '#{ contact_to_delete.full_name }' ..."
      sleep(1)
      puts "-------------------------------------------------------------------------"
      puts "Contact removed successfully."
      puts "-------------------------------------------------------------------------"
      print "Press any key to continue"
      gets.chomp
      Contact.delete(contact_to_delete)
      main_menu
    end

  end

  def display_all_contacts
    system("clear")
    all_contacts = Contact.all
    if all_contacts.size >= 1
      puts "----------------------------------------------------"
      puts "All contacts"
      puts "----------------------------------------------------"
      puts
        all_contacts.each do |contact|
          puts "Full Name: #{ contact.full_name }"
          puts "Email Address: #{ contact.email }"
          puts "Notes: #{ contact.note }"
          puts
        end
      puts
      puts "---------------------------------------------------------"
      print "Press any key to continue"
      gets.chomp
    else
      puts "There are no contact, please add one to view."
    end
  end

  def search_by_attribute
    system("clear")
    attribute_menu
    user_selected = gets.to_i
    puts
    attribute = attribute_option(user_selected)
    puts "Searching for user by '#{attribute}'"
    puts
    print "Please enter the '#{attribute}' for the user you wish to find: "
    value = gets.chomp
    result = Contact.find_by(attribute => value)
    display_search_result(result)
    result
  end

  def attribute_menu
    puts "----------------------------------------------------"
    puts "Find a contact"
    puts "----------------------------------------------------"
    puts
    puts "What contact attribute would you like to search by? "
    puts "---------------------------------------------------------"
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] Email Address'
    puts '[4] Notes'
    puts '[5] Go Back to Main Menu'
    puts "---------------------------------------------------------"
    print 'Enter a number: '
  end

  def attribute_option(user_selected)
      case user_selected
      when 1 then 'first_name'
      when 2 then 'last_name'
      when 3 then 'email'
      when 4 then 'note'
      when 5 then main_menu
      end
  end

  def display_search_result(result)
    if result == nil
      puts
      puts "Contact not found, please try again."
      puts "---------------------------------------------------------"
      print "Press any key to continue"
      gets.chomp
    else
      puts "----------------------------------------------------"
      puts "Search Result"
      puts "----------------------------------------------------"
      puts
      puts "Full Name: #{result.first_name} #{result.last_name}"
      puts "Email Address: #{result.email}"
      puts "Notes: '#{result.note}'"
      puts
      puts "---------------------------------------------------------"
      print "Press any key to continue"
      gets.chomp
    end

  end

end

at_exit do
  ActiveRecord::Base.connection.close
end


a_crm_app = CRM.new("My Contacts")
a_crm_app.main_menu
