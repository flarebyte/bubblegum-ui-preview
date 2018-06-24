#!/usr/bin/python

import sys
import csv
from string import Template

enumerations = {
    'content-appearance': [
        'ui:content-appearance/h1'
        , 'ui:content-appearance/h2'
        , 'ui:content-appearance/h3'
        , 'ui:content-appearance/h4'
        , 'ui:content-appearance/h5'
        , 'ui:content-appearance/h6'
        , 'ui:content-appearance/block-quote'
        , 'ui:content-appearance/paragraphs'
    ]
}