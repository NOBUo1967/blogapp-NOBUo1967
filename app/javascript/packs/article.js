import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      //commentsをすべて取得する。
      comments.forEach((comment) => {
        //commentsからcommentを一つづつ取り出す = Rubyのeach_methodと一緒
        //Rubyだとblockにはいるが、JSだとfunctionの中に入れられる
        $('.comments-container').append(
          `<div class="article_comment"><p>${comment.content}</p></div>`
          //append = タグの中にhtmlのタグを挿入していく
          //comment-containerの中に上記のhtmlを追加していく
          //上記のhtmlはもともとarticle.show.htmlで記載していた内容。
        )
      })
    })

  axios.get(`/articles/${articleId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })

  $('.inactive-heart').on('click', () => {
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status == 'ok'){
          $('.active-heart').removeClass('hidden')
          $('.inactive-heart').addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

  $('.active-heart').on('click', () => {
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status == 'ok'){
          $('.active-heart').addClass('hidden')
          $('.inactive-heart').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
})