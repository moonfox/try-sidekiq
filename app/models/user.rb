class User
  class << self
    def create_user(name, age)
      sleep 3
      puts "create user with name #{name} and age #{age}"
    end
  end
end
