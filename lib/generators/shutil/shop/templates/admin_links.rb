module Shops
  module AdminLinks
    def product_link(shopify_product_id)
      "https://#{shopify_domain}/admin/products/#{shopify_product_id}"
    end

    def product_query(query)
      query = query.gsub(/ +/, "+")
      "https://#{shopify_domain}/admin/products?query=#{query}"
    end

    def variant_link(shopify_product_id, shopify_variant_id)
      "https://#{shopify_domain}/admin/products/#{shopify_product_id}/variants/#{shopify_variant_id}"
    end

    def variant_direct_link(shopify_variant_id)
      "https://#{shopify_domain}/admin/variants/#{shopify_variant_id}"
    end

    def order_link(shopify_order_ref)
      "https://#{shopify_domain}/admin/orders/#{shopify_order_ref}"
    end
  end
end
