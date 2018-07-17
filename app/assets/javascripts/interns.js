// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// $(function () {
//     function generateSignature(callback, params_to_sign) {
//         $.ajax({
//             url: "/generate_signature",
//             type: "GET",
//             dataType: "text",
//             data: { data: params_to_sign },
//             success: function (signature, textStatus, xhr) {
//                 callback(signature);
//             },
//             error: function (xhr, status, error) {
//                 console.log(xhr, status, error);
//             }
//         });
//     }
//
//     $("#upload_widget_opener").click(function (e) {
//         e.preventDefault();
//         cloudinary.openUploadWidget({
//             cloud_name: 'demo',
//             api_key: 'a5vxnzbp',
//             upload_signature: generateSignature
//         }, function (error, result) {
//             console.log(error, result)
//         });
//     });
// });
$(document).on('turbolinks:load', function () {
    if ($.fn.cloudinary_fileupload !== undefined) {

        $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload({
            start: function () {
                console.log(arguments);
            }
        }).off("cloudinarydone").on("cloudinarydone", function (e, data) {
            var preview = $(".profile-picture-preview").html('');
            $.cloudinary.image(data.result.public_id, {
                format: data.result.format, width: 150, crop: "fit"
            }).appendTo(preview);
        });
        $('.cloudinary-fileupload').fileupload('option', 'replaceFileInput', false);
    }
});