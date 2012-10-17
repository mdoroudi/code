require 'zlib'

class TextSnippetGenerator

  def snippets(document, query)
    doc_tokens = document.split(doc_split_regexp)
    query_tokens = query.downcase.split(" ")

    hash_count = {}
    hash_str = {}

    query_tokens.each do |qt|
      search_res = doc_tokens.grep(/#{qt}/i) 
      search_res.each do |res_item|
        rkey = key(res_item)
        hash_count[rkey] = (hash_count[rkey] || 0) + 1
        hash_str[rkey] = res_item
      end
    end

    sort_by_popularity(hash_count, hash_str)
  end

  def snippet_paragraph(document, query)
    res_arr = snippets(document, query)
    res_arr.join("; ")
  end

  private

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
