#!/usr/bin/env bash
GRUPO=$1
CONSULTA="mysql -u root -h dbremedy remedy -pantonio -e "
$CONSULTA "SELECT * FROM cats WHERE owner = '${GRUPO}';"
