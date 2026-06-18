// Cloudflare Worker — 代理华为云 OBS，去掉强制下载头
// 访问 https://gewislab-blog.你的子域.workers.dev/ 即可在线预览

const OBS_BUCKET = 'gewislab-blog.obs-website.cn-north-4.myhuaweicloud.com'

export default {
  async fetch(request) {
    const url = new URL(request.url)
    let path = url.pathname

    // 默认首页
    if (path === '/' || path === '') {
      path = '/index.html'
    }

    // 构建 OBS 地址
    const obsUrl = `https://${OBS_BUCKET}${path}`

    try {
      const response = await fetch(obsUrl)

      // 复制响应头，但去掉 Content-Disposition
      const newHeaders = new Headers(response.headers)
      newHeaders.delete('content-disposition')
      // 确保 Content-Type 正确
      if (path.endsWith('.css')) {
        newHeaders.set('content-type', 'text/css')
      } else if (path.endsWith('.html')) {
        newHeaders.set('content-type', 'text/html')
      }

      return new Response(response.body, {
        status: response.status,
        statusText: response.statusText,
        headers: newHeaders,
      })
    } catch (err) {
      return new Response('Error: ' + err.message, { status: 500 })
    }
  },
}
