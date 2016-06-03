#!/bin/bash

if [ ! -d "trade-tariff-backend/.git" ]; then
  mkdir -p trade-tariff-backend
  git clone https://github.com/bitzesty/trade-tariff-backend trade-tariff-backend
  cd trade-tariff-backend
  git remote add alphagov https://github.com/alphagov/trade-tariff-backend
  git fetch
  cd ../
fi

if [ ! -d "trade-tariff-frontend/.git" ]; then
  mkdir -p trade-tariff-frontend
  git clone https://github.com/bitzesty/trade-tariff-frontend trade-tariff-frontend
  cd trade-tariff-frontend
  git remote add alphagov https://github.com/alphagov/trade-tariff-frontend
  git fetch
  cd ../
fi

if [ ! -d "trade-tariff-admin/.git" ]; then
  mkdir -p trade-tariff-admin
  git clone https://github.com/bitzesty/trade-tariff-admin trade-tariff-admin
  cd trade-tariff-admin
  git remote add alphagov https://github.com/alphagov/trade-tariff-admin
  git fetch
  cd ../
fi

if [ ! -d "signonotron2/.git" ]; then
  mkdir -p signonotron2
  git clone https://github.com/bitzesty/signonotron2 signonotron2
  cd signonotron2
  git remote add alphagov https://github.com/alphagov/signonotron2
  git fetch
  cd ../
fi