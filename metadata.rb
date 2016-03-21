name             'myapp'
maintainer       'Nowshad Amin'
maintainer_email 'nowshad.amin.bd@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures MyApp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

depends 'apache2', '~> 1.8.0'
depends 'mysql', '~> 4.0.0'
depends 'database', '~> 1.6.0'
depends 'php', '~> 1.3.0'
