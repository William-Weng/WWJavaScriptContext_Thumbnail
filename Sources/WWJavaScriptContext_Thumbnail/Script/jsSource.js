function thumbnailUrl(html) {
    
    let ogImage = html.match(/<meta +property="og:image" +content="([^"]+)"/i)
    let twitterImage = html.match(/<meta +name="twitter:image" +content="([^"]+)"/i)
    let thumbnailImage = html.match(/<meta +name="thumbnail" +content="([^"]+)"/i)
    
    return ogImage[1] ?? twitterImage[1] ?? thumbnailImage[1]
}
