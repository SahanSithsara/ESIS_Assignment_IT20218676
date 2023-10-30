/* ========================================================================
 * DECOM d.o.o.
 * Distribucija sadrzaja zabranjena
 * ========================================================================
 * Copyright 2013, DECOM d.o.o. Sarajevo
 * ======================================================================== */



jQuery(".dropdown-menu li.dropdown").on("mouseenter", function () {

    jQuery(this).find(".dropdown-menu").css({ "display": "inline-block" }, "slow");

}).on("mouseleave", function () {

    jQuery(this).find(".dropdown-menu").css({ "display": "none" }, "slow");

});
