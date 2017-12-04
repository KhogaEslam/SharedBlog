require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @author = Author.new(name: 'Example Author',
                         email: 'author@example.com',
                         password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @author.valid?
  end

  test 'name should be present' do
    @author.name = '     '
    assert_not @author.valid?
  end

  test 'email should be present' do
    @author.email = '     '
    assert_not @author.valid?
  end

  test 'name should not be too long' do
    @author.name = 'a' * 51
    assert_not @author.valid?
  end

  test 'email should not be too long' do
    @author.email = 'a' * 244 + '@example.com'
    assert_not @author.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[author@example.com author@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @author.email = valid_address
      assert @author.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[author@example,com author_at_foo.org author.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @author.email = invalid_address
      assert_not @author.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_author = @author.dup
    duplicate_author.email = @author.email.upcase
    @author.save
    assert_not duplicate_author.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @author.email = mixed_case_email
    @author.save
    assert_equal mixed_case_email.downcase, @author.reload.email
  end

  test 'password should be present (nonblank)' do
    @author.password = @author.password_confirmation = ' ' * 6
    assert_not @author.valid?
  end

  test 'password should have a minimum length' do
    @author.password = @author.password_confirmation = 'a' * 5
    assert_not @author.valid?
  end

  test 'authenticated? should return false for a author with nil digest' do
    assert_not @author.authenticated?('')
  end

  test 'associated articles should be destroyed' do
    @author.save
    @author.articles.create!(title: 'Title Sample',
                               content: 'Lorem ipsum dolor sit amet,
                                      consectetur adipiscing elit.
                                      Donec sed neque ut leo pulvinar vestibulum vel vitae ante.
                                      Nulla urna mauris, semper mollis ipsum.
                                      Maecenas ut leo nisl.
                                      Nam bibendum iaculis orci eu faucibus.
                                      Orci varius natoque penatibus et magnis dis parturient montes,
                                      nascetur ridiculus mus.')
    assert_difference 'Article.count', -1 do
      @author.destroy
    end
  end

  test 'should follow and unfollow a author' do
    khoga = authors(:khoga)
    mrmr  = authors(:mrmr)
    assert_not khoga.following?(mrmr)
    khoga.follow(mrmr)
    assert khoga.following?(mrmr)
    assert_not khoga.followers.include?(mrmr)
    mrmr.follow(khoga)
    assert khoga.followers.include?(mrmr)
    khoga.unfollow(mrmr)
    assert_not khoga.following?(mrmr)
  end

  test 'feed should have the right articles' do
    khoga = authors(:khoga)
    mrmr  = authors(:mrmr)
    maimona    = authors(:maimona)
    # Posts from followed author
    maimona.articles.each do |post_following|
      assert khoga.feed.include?(post_following)
    end
    # Posts from self
    khoga.articles.each do |post_self|
      assert khoga.feed.include?(post_self)
    end
    # Posts from unfollowed author
    mrmr.articles.each do |post_unfollowed|
      assert_not khoga.feed.include?(post_unfollowed)
    end
  end

  test 'should favorite and unfavorite an article' do
    khoga = authors(:khoga)
    six = articles(:six)
    assert_not khoga.favoring?(six)
    khoga.favorite(six)
    assert khoga.favoring?(six)
    assert six.favoraiters.include?(khoga)
    khoga.unfavorite(six)
    assert_not khoga.favoring?(six)
  end
end
