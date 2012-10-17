require 'zlib'
require 'active_support'
require 'active_support/inflector'

class TextSnippetGenerator

  MAX_RESULTS = 3

  def snippets(document, query)
    generate_all_snippets(document, query)[0...MAX_RESULTS]
  end

  def snippet_paragraph(document, query)
    res_arr = snippets(document, query)
    res_arr.join("; ")
  end

  def generate_all_snippets(document, query)
    doc_tokens = document.split(doc_split_regexp)
    query_tokens = query.downcase.split(" ")

    hash_count = {}
    hash_str = {}

    query_tokens.each do |qt|
      search_res = search_for_word(qt, doc_tokens)
      search_res.each do |res_item|
        rkey = key(res_item)
        hash_count[rkey] = (hash_count[rkey] || 0) + 1
        hash_str[rkey] = res_item
      end
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
    s_res = doc_tokens.grep(/#{word}/i) 
    s_res_singularize = doc_tokens.grep(/#{word.singularize}/i) 
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

  def key(token)
    Zlib.crc32(token)
  end

  def doc_split_regexp
    /[;,.]/
  end
end
