require 'spec_helper'

describe 'MyApp database' do

  it 'should be running the database server' do
    case RSpec.configuration.os[:family]
    when "Ubuntu"
      expect(service 'mysql').to be_running
      expect(service 'mysql').to be_enabled
    else
      expect(service 'mysqld').to be_running
      expect(service 'mysqld').to be_enabled
    end
  end

  it 'should have created the myapp database' do
    expect(command 'mysqlshow -uroot -prootpass').to return_stdout /.*myapp.*/
  end

  it 'should have created the myapp_app user' do
    expect(command 'mysql -uroot -prootpass -e "select user,host from mysql.user;"').to return_stdout /.*myapp_app\s+localhost.*/
  end

  it 'should have given the myapp_app database user rights to myapp' do
    expect(command 'mysql -uroot -prootpass -e "show grants for \'myapp_app\'@\'localhost\';"').to return_stdout /.*GRANT ALL PRIVILEGES ON `myapp`.\* TO \'myapp_app\'@\'localhost\'.*/
  end

  it 'should have created the users table' do
    expect(command 'mysql -hlocalhost -umyface_app -psupersecret -Dmyface -e "select id,user_name from users;"').to return_stdout /.*mbower.*/
  end

  it 'should have installed the Apache php5_module' do
    case RSpec.configuration.os[:family]
    when "Ubuntu"
      expect(command 'sudo /usr/sbin/apache2 -M | grep php5').to return_stdout /.*php5_module.*/
    else
      expect(command 'sudo /usr/sbin/httpd -M | grep php5').to return_stdout /.*php5_module.*/
    end
  end

end
