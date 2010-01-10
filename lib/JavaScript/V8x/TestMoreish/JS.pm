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

    _TestMoreish.test = {
    
        areEqual: function( got, expected ) { return got == expected; },
        isString: function( got ) { return typeof got === 'string'; },
        isValue: function( got ) { return this.isObject( got ) || this.isString( got ) || this.isNumber( got ) || this.isBoolean( got ); },
        isObject: function( got ) { return (got && (typeof got === 'object' || this.isFunction( got ))) || false; },
        isNumber: function( got ) { return typeof got === 'number' && isFinite( got ); },
        isBoolean: function( got ) { return typeof got === 'boolean'; },
        isFunction: function( got ) { return (typeof got === 'function') || Object.prototype.toString.apply( got ) === '[object Function]'; },
        like: function( got, match ) {
            if (this.isString( match )) match = new RegExp( match );
            return this.isValue( got ) && this.isString( got ) && got.match( match );
        }
    };

    _TestMoreish._areEqual = function( got, expected, name ) {
        return this.test.areEqual( got, expected ) ?
            { name: name } :
            this._comparisonFailure( got, expected, name, "Value is not equal" );
    };

    _TestMoreish._like = function( got, match, name ) {
        return this.test.like( got, match ) ?
            { name: name } :
            this._comparisonFailure( got, match, name, "Value does not match regular expression" );
    };
	
//    _formatMessage : function (customMessage /*:String*/, defaultMessage /*:String*/) /*:String*/ {
//        var message = customMessage;
//        if (YAHOO.lang.isString(customMessage) && customMessage.length > 0){
//            return YAHOO.lang.substitute(customMessage, { message: defaultMessage });
//        } else {
//            return defaultMessage;
//        }        
//    },

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
        'like',
//        'areNotEqual',
//        'areSame',
//        'areNotSame',
//        'fail',
//        'isTypeOf',
//        'isArray',
//        'isBoolean',
//        'isFunction',
//        'isNumber',
//        'isObject',
//        'isString',
//        'isInstanceOf',
//        'isTrue',
//        'isFalse',
//        'isNaN',
//        'isNotNaN',
//        'isNull',
//        'isNotNull',
//        'isUndefined',
//        'isNotUndefined'
    ];

    for (var ii = 0; ii < _test.length; ii++) {
        var name = _test[ii];
        _TestMoreish[name] = _installTest( name );
    }

})();

_END_
}

1;
