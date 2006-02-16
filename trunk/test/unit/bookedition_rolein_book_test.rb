require File.dirname(__FILE__) + '/../test_helper'

class BookeditionRoleinBookTest < Test::Unit::TestCase
  fixtures :bookedition_rolein_books

  def test_should_create_bookedition_rolein_book
    assert create_bookedition_rolein_book.valid?
  end

  def test_should_require_login
    u = create_bookedition_rolein_book(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_bookedition_rolein_book(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_bookedition_rolein_book(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_bookedition_rolein_book(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    bookedition_rolein_books(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal bookedition_rolein_books(:quentin), BookeditionRoleinBook.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    bookedition_rolein_books(:quentin).update_attribute(:login, 'quentin2')
    assert_equal bookedition_rolein_books(:quentin), BookeditionRoleinBook.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_bookedition_rolein_book
    assert_equal bookedition_rolein_books(:quentin), BookeditionRoleinBook.authenticate('quentin', 'quentin')
  end

  protected
  def create_bookedition_rolein_book(options = {})
    BookeditionRoleinBook.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
  end
end