

function ErrorDialog(title, message) {

    buttonHTML = '<a class="btn btn-primary" id="dataConfirmOK" data-dismiss="modal">OK</a>';

    if (!$('#dataConfirmModal').length) {
        $('body').append('<div id="dataConfirmModal" class="modal fade" role="dialog" aria-labelledby="dataConfirmLabel" aria-hidden="true">' +
        					'<div class="modal-dialog modal-sm">' +
        						'<div class="modal-content">' +
        							'<div class="modal-header">' +
        								'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        								'<h4 id="dataConfirmLabel" class="modal-title-text"><span class="glyphicon glyphicon-alert"></span> Error</h4>' +
        							'</div>' +
        							'<div class="modal-body">' +
        							'</div>' +
        							'<div class="modal-footer">' +
        								'<a class="btn btn-primary" id="dataConfirmOK" data-dismiss="modal">OK</a>' +
        							'</div>' +
        						'</div>' +
        					'</div>' +
        				'</div>');
    }
    $('#dataConfirmModal').find('.modal-body').html(message);
    $('#dataConfirmModal').find('.modal-footer').html(buttonHTML);

    if (title != null) {
        $('#dataConfirmLabel').html('<span class="glyphicon glyphicon-alert"></span> ' + title);
    }

    $('#dataConfirmModal').modal({ show: true });

}


function InfoDialog(title, message) {

    buttonHTML = '<a class="btn btn-primary" id="dataConfirmOK" data-dismiss="modal">OK</a>';

    if (!$('#dataConfirmModal').length) {
        $('body').append('<div id="dataConfirmModal" class="modal fade" role="dialog" aria-labelledby="dataConfirmLabel" aria-hidden="true">' +
        					'<div class="modal-dialog modal-sm">' +
        						'<div class="modal-content">' +
        							'<div class="modal-header">' +
        								'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        								'<h4 id="dataConfirmLabel" class="modal-title-text"><span class="glyphicon glyphicon-info-sign"></span> Info</h4>' +
        							'</div>' +
        							'<div class="modal-body">' +
        							'</div>' +
        							'<div class="modal-footer">' +
        								'<a class="btn btn-primary" id="dataConfirmOK" data-dismiss="modal">OK</a>' +
        							'</div>' +
        						'</div>' +
        					'</div>' +
        				'</div>');
    }
    $('#dataConfirmModal').find('.modal-body').html(message);
    $('#dataConfirmModal').find('.modal-footer').html(buttonHTML);

    if (title != null) {
        $('#dataConfirmLabel').html('<span class="glyphicon glyphicon-info-sign"></span> ' + title);
    }

    $('#dataConfirmModal').modal({ show: true });

}

function OKCancelDialog(title, message, onOKClick) {

    buttonHTML = '<a class="btn btn-primary" id="dataConfirmOK" data-dismiss="modal">OK</a>' +
        		 '<a class="btn btn-default" id="dataConfirmCancel" data-dismiss="modal">Cancel</a>';

    if (!$('#dataConfirmModal').length) {
        $('body').append('<div id="dataConfirmModal" class="modal fade" role="dialog" aria-labelledby="dataConfirmLabel" aria-hidden="true">' +
        					'<div class="modal-dialog modal-sm">' +
        						'<div class="modal-content">' +
        							'<div class="modal-header">' +
        								'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        								'<h4 id="dataConfirmLabel" class="modal-title-text">OK/Cancel</h4>' +
        							'</div>' +
        							'<div class="modal-body">' +
        							'</div>' +
        							'<div class="modal-footer">' +
        								'<a class="btn btn-primary" id="dataConfirmOK" data-dismiss="modal">OK</a>' +
        								'<a class="btn btn-default" id="dataConfirmCancel" data-dismiss="modal">Cancel</a>' +
        							'</div>' +
        						'</div>' +
        					'</div>' +
        				'</div>');
    }
    $('#dataConfirmModal').find('.modal-body').html(message);
    $('#dataConfirmModal').find('.modal-footer').html(buttonHTML);

    $('#dataConfirmOK').attr('onclick', onOKClick);
    if (title != null) {
        $('#dataConfirmLabel').html(title);
    }



    $('#dataConfirmModal').modal({ show: true });

}
function YesNoDialog(title, message, onYesClick, onNoClick) {


    buttonHTML = '<a class="btn btn-primary" id="dataConfirmYes" data-dismiss="modal">Yes</a>' +
        		'<a class="btn btn-default" id="dataConfirmNo" data-dismiss="modal">No</a>';

    if (!$('#dataConfirmModal').length) {
        $('body').append('<div id="dataConfirmModal" class="modal fade" role="dialog" aria-labelledby="dataConfirmLabel" aria-hidden="true">' +
        					'<div class="modal-dialog modal-sm">' +
        						'<div class="modal-content">' +
        							'<div class="modal-header">' +
        								'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        								'<h4 id="dataConfirmLabel" class="modal-title-text">Yes/No</h4>' +
        							'</div>' +
        							'<div class="modal-body">' +
        							'</div>' +
        							'<div class="modal-footer">' +
        								'<a class="btn btn-primary" id="dataConfirmYes" data-dismiss="modal">Yes</a>' +
        								'<a class="btn btn-default" id="dataConfirmNo" data-dismiss="modal">No</a>' +
        							'</div>' +
        						'</div>' +
        					'</div>' +
        				'</div>');
    }

    $('#dataConfirmModal').find('.modal-body').html(message);
    $('#dataConfirmModal').find('.modal-footer').html(buttonHTML);

    $('#dataConfirmYes').attr('onclick', onYesClick);
    $('#dataConfirmNo').attr('onclick', onNoClick);

    if (title != null) {
        $('#dataConfirmLabel').html(title);
    }



    $('#dataConfirmModal').modal({ show: true });

}
function YesNoCancelDialog(title, message, onYesClick, onNoClick) {

    buttonHTML = '<a class="btn btn-primary" id="dataConfirmYes" data-dismiss="modal">Yes</a>' +
				'<a class="btn btn-default" id="dataConfirmNo" data-dismiss="modal">No</a>' +
				'<a class="btn btn-default" id="dataConfirmCancel" data-dismiss="modal">Cancel</a>';
    if (!$('#dataConfirmModal').length) {
        $('body').append('<div id="dataConfirmModal" class="modal fade" role="dialog" aria-labelledby="dataConfirmLabel" aria-hidden="true">' +
        					'<div class="modal-dialog modal-sm">' +
        						'<div class="modal-content">' +
        							'<div class="modal-header">' +
        								'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        								'<h4 id="dataConfirmLabel" class="modal-title-text">Yes/No/Cancel</h4>' +
        							'</div>' +
        							'<div class="modal-body">' +
        							'</div>' +
        							'<div class="modal-footer">' +
        								'<a class="btn btn-primary" id="dataConfirmYes" data-dismiss="modal">Yes</a>' +
        								'<a class="btn btn-default" id="dataConfirmNo" data-dismiss="modal">No</a>' +
        								'<a class="btn btn-default" id="dataConfirmCancel" data-dismiss="modal">Cancel</a>' +
        							'</div>' +
        						'</div>' +
        					'</div>' +
        				'</div>');
    }


    $('#dataConfirmModal').find('.modal-body').html(message);
    $('#dataConfirmModal').find('.modal-footer').html(buttonHTML);

    $('#dataConfirmYes').attr('onclick', onYesClick);
    $('#dataConfirmNo').attr('onclick', onNoClick);

    if (title != null) {
        $('#dataConfirmLabel').html(title);
    }



    $('#dataConfirmModal').modal({ show: true });

}
$(document).ready(function () {
    $('.data-error-dialog').click(function (ev) {
        var title = $(this).attr('data-modal-title');
        var body = $(this).attr('data-modal-body');

        ErrorDialog(title, body);

        return false;
    });
    $('.data-info-dialog').click(function (ev) {
        var title = $(this).attr('data-modal-title');
        var body = $(this).attr('data-modal-body');

        InfoDialog(title, body);

        return false;
    });
    $('.data-okcancel-dialog').click(function (ev) {
        var title = $(this).attr('data-modal-title');
        var body = $(this).attr('data-modal-body');
        var okClick = $(this).attr('data-modal-okclick');

        OKCancelDialog(title, body, okClick);

        return false;
    });
    $('.data-yesno-dialog').click(function (ev) {
        var title = $(this).attr('data-modal-title');
        var body = $(this).attr('data-modal-body');
        var yesClick = $(this).attr('data-modal-yesclick');
        var noClick = $(this).attr('data-modal-noclick');

        YesNoDialog(title, body, yesClick, noClick);

        return false;
    });
    $('.data-yesnocancel-dialog').click(function (ev) {
        var title = $(this).attr('data-modal-title');
        var body = $(this).attr('data-modal-body');
        var yesClick = $(this).attr('data-modal-yesclick');
        var noClick = $(this).attr('data-modal-noclick');

        YesNoCancelDialog(title, body, yesClick, noClick);

        return false;
    });
})