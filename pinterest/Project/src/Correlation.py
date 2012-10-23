'''
Created on Jun 10, 2012

Correlation module contains all the implementations for computing correlations

@author: vivianxu
'''

from difflib import SequenceMatcher

# A list of words are ignored when calculate string correlation
# We might need a more comprehensive list than this
ignored_words = {"a", "the", "is", "i"}

class CorCache(object):
    '''
    CorCache class implements a cache for correlation pairs. 
    The key is the pair of ids and cached value is the correlation. A more 
    comprehensive cache should be implemented with following interfaces:
        - mark_dirty(d1,d2)
        - clear_cache()
        - check_timeout()
        - ...
    '''
    
    def __init__(self):
        '''
        Constructor
        '''
        self.__cache = {};
    
    
    @staticmethod
    def __key(d1, d2):
        '''
        Construct the internal key string from two ids. 
        As correlation(d1,d2) == correlation(d2,d1), the constructed key string 
        is always "smallerid_largerid" 
        '''
        assert(d1 != d2)
        if d1 > d2:
            d1, d2 = d2, d1
            
        return str(d1) + "_" + str(d2)
        
            
    def update(self, id1, id2, cor):
        self.__cache[CorCache.__key(id1, id2)] = cor
        
        
    def get(self, id1, id2):
        return self.__cache[CorCache.__key(id1, id2)]
    
    
    def has(self, id1, id2):
        return self.__cache.has_key(CorCache.__key(id1, id2)) 



class CorCalc(object):
    '''
    CorCalc class implements a calculator to compute correlations for pairs. 
    '''

    @staticmethod
    def get_correlation_str(s1, s2):
        '''
        Calculate the correlation between string.
        For simplicity, it only uses string comparison. But more comprehensive
        algorithm can be employed here.
        Current implementation removes some trivial words from the string for 
        better correlation detection
        '''
        if s1 == None or s2 == None:
            return 0
        for w in ignored_words:
            s1 = s1.replace(w, "")
            s2 = s2.replace(w, "")
        return SequenceMatcher(None, s1, s2).ratio()
        
        
    @staticmethod
    def get_correlation_url(url1, url2):
        '''
        Calculate the correlation between urls.
        For simplicity, it only uses string comparison. But more comprehensive
        algorithm considering URL patterns can be employed here.
        '''
        if url1 == None or url2 == None:
            return 0    
        return SequenceMatcher(None, url1, url2).ratio()
 


    
    