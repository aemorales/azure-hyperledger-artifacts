# Following instructions from:
# https://hyperledger.github.io/composer/latest/tutorials/developer-tutorial.html


# For debugging create $HOME/tutorial-network/config/default.json
# and put the following in it before running the composer commands:
# {
#   "composer": {
#     "log": {
#       "debug": "composer[debug]:*",
#       "console": {
#         "maxLevel": "debug"
#       },
#       "file": {
#         "filename" : "./log.txt"
#       }
#     }
#   }
# }

cd ~/tutorial-network

composer archive create -t dir -n .

cp ~/crypto-config/peerOrganizations/{{PEER_ORG_DOMAIN}}/users/Admin@{{PEER_ORG_DOMAIN}}/msp/signcerts/Admin@{{PEER_ORG_DOMAIN}}-cert.pem .
cp ~/crypto-config/peerOrganizations/{{PEER_ORG_DOMAIN}}/users/Admin@{{PEER_ORG_DOMAIN}}/msp/keystore/* Admin@{{PEER_ORG_DOMAIN}}_sk

composer card create -p connection.json -u PeerAdmin -c Admin@{{PEER_ORG_DOMAIN}}-cert.pem -k Admin@{{PEER_ORG_DOMAIN}}_sk -r PeerAdmin -r ChannelAdmin
composer card import -f PeerAdmin@trustt-network.card
composer network install -c PeerAdmin@trustt-network -a trustt-network@0.0.1.bna

composer network start --networkName trustt-network --networkVersion 0.0.1 -A {{CA_USER}} -S {{CA_PASSWORD}} -c PeerAdmin@trustt-network
composer card import -f admin@trustt-network.card
composer network ping -c admin@trustt-network

