signonotron: sh -c 'cd ./signonotron2/ && GDS_SSO_STRATEGY=real bundle exec rails s -p 3016'
backend: sh -c 'cd ./trade-tariff-backend/ && bundle exec rails s -p 3018'
frontend: sh -c 'cd ./trade-tariff-frontend/ && TARIFF_API_HOST=localhost:3018 bundle exec rails s -p 3017'
admin: sh -c 'cd ./trade-tariff-admin/ &&  TARIFF_API_HOST=localhost:3018 bundle exec rails s -p 3046'
