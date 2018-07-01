#!/usr/bin/python

import sys
import csv
from string import Template

enumerations = {
    'content-appearance': [
        'ui:content-appearance/header/one'
        , 'ui:content-appearance/header/two'
        , 'ui:content-appearance/header/three'
        , 'ui:content-appearance/header/four'
        , 'ui:content-appearance/header/five'
        , 'ui:content-appearance/header/six'
        , 'ui:content-appearance/block-quote'
        , 'ui:content-appearance/paragraphs'
        , 'ui:content-appearance/code'
        , 'ui:content-appearance/sample'
        , 'ui:content-appearance/dark'
        , 'ui:content-appearance/primary'
        , 'ui:content-appearance/info'
        , 'ui:content-appearance/success'
        , 'ui:content-appearance/warning'
        , 'ui:content-appearance/danger'
    ]
}