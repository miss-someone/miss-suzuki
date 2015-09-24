# 応募フォームでのcropパラメタをinput hiddenに埋め込む
update_crop_params = (x, y, h, w) ->
  $('#crop_param_x').val x
  $('#crop_param_y').val y
  $('#crop_param_height').val h
  $('#crop_param_width').val w

# プレビュー画像の差し替え
replace_img = (img_path) ->
  $('#entry_img_preview > img').cropper("replace", img_path)

# 画像cropのライブラリであるcropperの初期化
$ ->
  $('#entry_img_preview > img').cropper(
    aspectRatio: 1
    autoCropArea: 0.65
    strict: false
    guides: false
    highlight: false
    dragCrop: true
    zoomable: false
    cropBoxMovable: true
    cropBoxResizable: true
    built: ->
      params = $("#entry_img_preview > img").cropper("getData")
      update_crop_params params.x, params.y, params.height, params.width
    crop: (e) ->
      update_crop_params e.x, e.y, e.height, e.width
  )

# エントリー画像が変化した時に，プレビュー画像を差し替える
$ ->
  fileInput = $('#image_input')
  originalPath = $('#entry_img_preview > img').attr('src')
  fileInput.change ->
    file = $(@).prop('files')[0]
    fileReader = new FileReader()
    if !@.files.length
      replace_img(originalPath)
      return
    else
      if !file.type.match('image.*')
        replace_img(originalPath)
        return
      else
        path = URL.createObjectURL(file)
        replace_img(path)

# フォームのバリデーション
$ ->
  $.extend $.validator.messages, {
    required: "*必須項目です"
    email: "*正しいメールアドレスの形式で入力してください"
    url: "*'http://'もしくは'https://'から始まる形式で入力してください"
    rangelength: jQuery.validator.format("*{0}文字以上{1}文字以下で入力してください")
  }
  rules = {
    "contestant[contestant_profile_attributes][name]": {required: true},
    "contestant[contestant_profile_attributes][hurigana]": {required: true},
    "contestant[contestant_profile_attributes][come_from]": {required: true},
    "contestant[contestant_profile_attributes][height]": {required: true},
    "contestant[contestant_profile_attributes][comment]": {required: true},
    "contestant[contestant_profile_attributes][link_url]": {url: true},
    "contestant[contestant_profile_attributes][thanks_comment]": {required: true},
    "contestant[contestant_profile_attributes][profile_image]": {required: true},
    "contestant[email]": {required: true, email: true},
    "contestant[password]": {required: true, rangelength: [8, 30]},
    "contestant[contestant_profile_attributes][is_share_with_twitter_ok]": {required: true},
    "contestant[contestant_profile_attributes][is_interest_in_idol_group]": {required: true},
    "contestant[agreement]": {required: true}
  }
  messages = {
    "contestant[agreement]": {required: "*利用規約への同意が必要です"}
  }
  $('#new_contestant').validate {rules: rules, messages: messages}

# マイページのスライドショー用
$ ->
  $('.bxslider').bxSlider({
      mode: 'fade',
      speed: 500,
      auto: false,
      pause: 3000,
      controls:true,
      pager: true
    })
