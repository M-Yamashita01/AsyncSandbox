class User < ApplicationRecord

  # before_validation :hoge_validation
  after_update :hoge_validation

  def hoge_validation
    puts '---hoge_validation---'
  end


  def send_message
    #raise StandardError.new('Exception occurred.')
    puts '----send_message---'
  end

  def before
    # puts '----before---'
  end

  def success
    # puts '----success---'
  end

  def max_attempts
    1
  end

  def self.send_delay_message
    user = new
    user.save!
    # Delayed::Worker.lifecycle.before(:enqueue) do
      # puts '---before_action---'
    # end
    user.delay(priority: 10, run_at: Time.now + 10).send_message 
  end
end
