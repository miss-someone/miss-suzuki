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
