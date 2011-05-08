ENVIRONMENT = :production

CONFIG = {
  :production => {
    :apps => [
      {
        :ip => 'host-ip-address',
        :ram => 500,
      },
    ],
    :db => {
      :ip => 'host-ip-address',
      :ram => 500
    }
  }
}

REE_PATH = "/usr/local/ruby-enterprise"
PASSENGER_VERSION = '3.0.7'
USER_TO_ADD = 'deploy'
