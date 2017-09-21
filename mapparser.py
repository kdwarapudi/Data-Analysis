#!/usr/bin/env python

import xml.etree.ElementTree as ET
import pprint

def count_tags(filename):
    """count tags in filename.
    
    Init 1 in dict if the key not exist, increment otherwise."""
    tags = {}
    for ev,elem in ET.iterparse(filename):
        tag = elem.tag
        if tag not in tags.keys():
            tags[tag] = 1
        else:
            tags[tag]+=1
    return tags

pprint.pprint(count_tags(OSMFILE))