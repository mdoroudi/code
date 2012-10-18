%w(zlib active_support/inflector active_support).each {|lib| require lib}
require_relative 'configuration'

class TextSnippetGenerator

  MAX_RESULTS = 3
  EXPLICIT_SEARCH_INC_FACTOR = 2

  def snippets(document, query)
    generate_all_snippets(document, query)[0...MAX_RESULTS]
  end

  def snippet_paragraph(document, query)
    res_arr = snippets(document, query)
    res_arr.join("; ")
  end

  def generate_all_snippets(document, query)
    doc_tokens = document.split(doc_split_regexp)
    query_tokens = tokenize_query(query)

    hash_count = {}
    hash_str = {}

    explicit_search = grep_doc(doc_tokens, query) 
    clean_search_results_and_counts!(explicit_search, hash_count, hash_str, EXPLICIT_SEARCH_INC_FACTOR) 
    
    query_tokens.each do |qt|

      search_res = search_for_word(qt, doc_tokens)
      synonym_search_res = search_of_many_words(synonyms(qt), doc_tokens)
      hypernyms_search_res = search_of_many_words(hypernyms(qt), doc_tokens)
      all_results = search_res + synonym_search_res + hypernyms_search_res

      clean_search_results_and_counts!(all_results, hash_count, hash_str) 
    end

    sort_by_popularity(hash_count, hash_str)
  end

  def max_results
    MAX_RESULTS
  end

  private

  # search for the current word and if its not in the document, 
  # singularize it and search again
  def search_for_word(word, doc_tokens)
    s_res = grep_doc(doc_tokens, word) 
    s_res_singularize = grep_doc(doc_tokens, word.singularize)
    search_res = s_res.size >= s_res_singularize.size ? s_res : s_res_singularize
    search_res
  end

  # sort the results by the line with most hits to be first
  def sort_by_popularity(hash_cnt, hash_res)
    sorted_hash = hash_cnt.sort_by {|key, count| -count}
    res = []
    
    sorted_hash.each do |tuple|
      res << hash_res[tuple[0]]
    end
    res
  end

  # given an array words, don't process anything just search the document tokens for the words
  def search_of_many_words(words, doc_tokens)
    words.collect { |word| grep_doc(doc_tokens, word).first }.compact
  end

  # increment factor is so if some search results are more important, for example in 
  # explicit search where we search for the whole query vs token by token if something match
  # the whole query, it's more important that matching only one word
  def clean_search_results_and_counts!(results, hash_count, hash_str, increment_factor=1)
    results.each do |res_item| 
      rkey = key(res_item)
      hash_count[rkey] = (hash_count[rkey] || 0) + increment_factor
      hash_str[rkey] = res_item
    end
    {count: hash_count, results: hash_str}
  end

  def grep_doc(doc_tokens, query)
     doc_tokens.grep(/#{query}/i) 
  end

  def synonyms(word)
    res = Wordnik.word.get_related(word.singularize, :type => 'synonym').first
    res.nil? ? [] : res["words"] 
  end

  def hypernyms(word)
    if word.singularize == word
      res = Wordnik.word.get_related(word, :type => 'hypernym', :use_canonical => true).first 
      res = res.nil? ? [] : res["words"] 
    else
      res = Wordnik.word.get_related(word.singularize, :type => 'hypernym', :use_canonical => true).first
      res = res.nil? ? [] : res["words"] 
      res_plural += Wordnik.word.get_related(word, :type => 'hypernym', :use_canonical => true).first  
      res += res.nil? ? [] : res["words"] 
    end
    res
  end

  def tokenize_query(query)
     query.downcase.split(" ") - stop_words
  end

  def key(token)
    Zlib.crc32(token)
  end

  def doc_split_regexp
    /[;,.]/
  end

  def stop_words
    %w(on at in the that is at a an this and are as but how or)
  end
end
