$(function () {
    $('form').validator({
        validHandlers: {
            '.customhandler': function (input) {
                //may do some formatting before validating
                input.val(input.val().toUpperCase());
                //return true if valid
                return input.val() === 'JQUERY' ? true : false;
            }
        }
    });

    $('form').submit(function (e) {
        e.preventDefault();

        if ($('form').validator('check') < 1) {
            alert('Hurray, your information will be saved!');
        }
    })
})