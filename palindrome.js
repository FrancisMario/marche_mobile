


Palindrome = (start, end) => {

    var algorithm = (value)  => {
        var array = value.toString().split("");

        var a = null;
        var b = null;

        array.forEach(e=>{
            a += Number.parseInt(e);
        });
        
        array.reverse().forEach(e=>{
            b += Number.parseInt(e);
        })

    
        console.log(a,b)
        if (a == b) {
            return true;
        }
        return false;

    }

    var count = 0;
    for (let index = start; index <= end; index++) {
        if (algorithm(index)) {
            count++
        }
    }
    return count;
}

console.log("palindrome count :",Palindrome(0,10));
