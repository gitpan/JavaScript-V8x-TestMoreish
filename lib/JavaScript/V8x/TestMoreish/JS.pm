package JavaScript::V8x::TestMoreish::JS;

use strict;
use warnings;

sub TestMoreish {
    <<'_END_'
if (! _TestMoreish)
    var _TestMoreish = {};

(function(){ 

	_TestMoreish._ok = function( ok, name ) {
        _TestMoreish_ok( ok, name );
    }

	_TestMoreish._diag = function( diag ) {
        _TestMoreish_diag( diag );
    }

    function getErrorObject(){
      try { throw Error('') } catch(err) { return err; }
    }

    _TestMoreish._comparisonFailure = function( have, want, name, _error ) {
        
        var error = _error + 
            "\nGot: " + have + " (" + (typeof have) + ")"  +
            "\nExpected: " + want + " (" + (typeof want) + ")";

        return { name: name, error: error };
    };

    _TestMoreish._areEqual = function( have, want, name ) {
        if ( have != want )
            return this._comparisonFailure( have, want, name, "Values should be equal." );
        return { name: name };
    };
	
//    _formatMessage : function (customMessage /*:String*/, defaultMessage /*:String*/) /*:String*/ {
//        var message = customMessage;
//        if (YAHOO.lang.isString(customMessage) && customMessage.length > 0){
//            return YAHOO.lang.substitute(customMessage, { message: defaultMessage });
//        } else {
//            return defaultMessage;
//        }        
//    },

//    isString: function(o) {
//        return typeof o === 'string';
//    },
//        
//    getMessage : function () /*:String*/ {
//        return this.message + "\nExpected: " + this.expected + " (" + (typeof this.expected) + ")"  +
//            "\nActual:" + this.actual + " (" + (typeof this.actual) + ")";
//    }

    var _installTest = function( test ) {
		return function() {
            var tester = this['_' + test];
            var result = tester.apply( this, arguments );
            this._ok( result.error ? 0 : 1, result.name );
            if ( result.error ) {
                this._diag( result.error );
            }
            return result.error ? 0 : 1;
        };
    }

    // Public API

    _TestMoreish.diag = function() { this._diag.apply( this, arguments ) };

    var _test = [
        'areEqual',
/*
        'areNotEqual',
        'areSame',
        'areNotSame',
        'fail',
        'isTypeOf',
        'isArray',
        'isBoolean',
        'isFunction',
        'isNumber',
        'isObject',
        'isString',
        'isInstanceOf',
        'isTrue',
        'isFalse',
        'isNaN',
        'isNotNaN',
        'isNull',
        'isNotNull',
        'isUndefined',
        'isNotUndefined'
*/
    ];

    for (ii = 0; ii < _test.length; ii++) {
        var name = _test[ii];
        _TestMoreish[name] = _installTest( name );
    }

})();

_END_
}

1;
