#!/bin/bash
declare -a words=(
'parser implementation' 'parserimplementation' 'prestanda analys'
'prestanda-analys' 'lua språket' 'syntax-highlighter' ' editor'
'hittas i figur' ' lookahead' ' backtracker' ' backtracking'
'gnu projektet' 'array' 'prestanda analys' 'kontextfrigrammatik'
'syntax analys' 'syntastisk'
)

IFS="|"
ack -a -G '\.tex$' "${words[*]}"
IFS=" "
