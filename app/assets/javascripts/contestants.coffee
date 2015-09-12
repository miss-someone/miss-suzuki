# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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
    crop: (e) ->
      crop_param_input = $('#crop_param')
      crop_val = e.height + ',' + e.width + ',' + e.x + ',' + e.y
      crop_param_input.val(crop_val)
      console.log crop_val
  )

$ ->
  fileInput = $('#image_input')
  filePreviewCanvas = $('.cropper-canvas > img')
  filePreviewBox = $('.cropper-view-box > img')
  prevElem = filePreviewCanvas
  originalPath = prevElem.attr('src')
  fileInput.change ->
    file = $(@).prop('files')[0]
    fileReader = new FileReader()

    if !@.files.length
      prevElem.attr('src', originalPath)
      return
    else
      if !file.type.match('image.*')
        prevElem.attr('src', originalPath)
        return
      else
        path = URL.createObjectURL(file)
        $('#entry_img_preview > img').cropper("replace", path)
