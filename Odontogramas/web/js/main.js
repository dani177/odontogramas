/*
 * jQuery File Upload Plugin JS Example 6.7
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {
    'use strict';

    var maxFilesAllowed=8;
    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
        maxFileSize: 5000000,
        acceptFileTypes: /(\.|\/)(gif|jpg|png)$/i,
        maxNumberOfFiles: maxFilesAllowed
    // dropZone: null
    });
    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
            )
        );
 
    if (window.location.hostname === '127.0.0.1') {
        // Demo settings:
        $('#fileupload').fileupload('option', {
            url: '//Odontogramas/',
            maxFileSize: 50000000,
            maxNumberOfFiles: 8,
            acceptFileTypes: /(\.|\/)(gif|jpg|png)$/i,
            process: [
            {
                action: 'load',
                fileTypes: /^image\/(gif|jpg|png)$/,
                maxFileSize: 20000000 // 20MB
            },
            {
                action: 'resize',
                maxWidth: 1440,
                maxHeight: 900
            },
            {
                action: 'save'
            }
            ]
        });
        // Upload server status check for browsers with CORS support:
        if ($.support.cors) {
            $.ajax({
                url: '//Odontogramas/',
                type: 'HEAD'
            }).fail(function () {
                $('<span class="alert alert-error"/>')
                .text('Servidor de carga no disponible en este momento - ' +
                    new Date())
                .appendTo('#fileupload');
            });
        }
    } else {
        // Load existing files:
        $('#fileupload').each(function () {
            var that = this;
            $.getJSON("/Odontogramas/cargar", function (result) {
                if (result && result.length) {
                    $(that).fileupload('option', 'maxNumberOfFiles', maxFilesAllowed - result.length);
                    $(that).fileupload('option', 'done').call(that, null, {
                        result: result
                    });
                    $(that).data('fileupload')._adjustMaxNumberOfFiles(0);
                   
                }
            });
        });
    }

});
