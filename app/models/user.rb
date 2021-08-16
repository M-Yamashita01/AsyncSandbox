class User < ApplicationRecord

  def send_message
    puts '----send_message---'
  end

  def self.send_delay_message
    user = new
    user.save!
    Delayed::Worker.lifecycle.before(:enqueue) do
      puts '---before_action---'
    end
    user.delay(priority: 10, run_at: Time.now + 10).send_message 
  end
end
