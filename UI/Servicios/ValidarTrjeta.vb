Public Class ValidarTrjeta
    Private Const cardRegex As String = "^(?:(?<Visa>4\d{3})|(?<MasterCard>5[1-5]\d{2})|(?<Discover>6011)|(?<DinersClub>(?:3[68]\d{2})|(?:30[0-5]\d))|(?<Amex>3[47]\d{2}))([ -]?)(?(DinersClub)(?:\d{6}\1\d{4})|(?(Amex)(?:\d{6}\1\d{5})|(?:\d{4}\1\d{4}\1\d{4})))$"

    Public Shared Function IsValidNumber(ByVal cardNum As String) As Boolean
        Dim cardTest As New Regex(cardRegex)

        'Determine the card type based on the number
        Dim cardType As CreditCardTypeType = GetCardTypeFromNumber(cardNum)

        'Call the base version of IsValidNumber and pass the 
        'number and card type
        If IsValidNumber(cardNum, cardType) Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Shared Function IsValidNumber(ByVal cardNum As String, ByVal cardType As CreditCardTypeType) As Boolean
        'Create new instance of Regex comparer with our 
        'credit card regex pattern
        Dim cardTest As New Regex(cardRegex)

        'Make sure the supplied number matches the supplied
        'card type
        If cardTest.Match(cardNum).Groups(cardType.ToString()).Success Then
            'If the card type matches the number, then run it
            'through Luhn's test to make sure the number appears correct
            If PassesLuhnTest(cardNum) Then
                Return True
            Else
                Return False
                'The card fails Luhn's test
            End If
        Else
            Return False
            'The card number does not match the card type
        End If
    End Function

    Public Shared Function GetCardTypeFromNumber(ByVal cardNum As String) As CreditCardTypeType
        'Create new instance of Regex comparer with our
        'credit card regex pattern
        Dim cardTest As New Regex(cardRegex)

        'Compare the supplied card number with the regex
        'pattern and get reference regex named groups
        Dim gc As GroupCollection = cardTest.Match(cardNum).Groups

        'Compare each card type to the named groups to 
        'determine which card type the number matches
        If gc(CreditCardTypeType.Amex.ToString()).Success Then
            Return CreditCardTypeType.Amex
        ElseIf gc(CreditCardTypeType.MasterCard.ToString()).Success Then
            Return CreditCardTypeType.MasterCard
        ElseIf gc(CreditCardTypeType.Visa.ToString()).Success Then
            Return CreditCardTypeType.Visa
        ElseIf gc(CreditCardTypeType.Discover.ToString()).Success Then
            Return CreditCardTypeType.Discover
        Else
            'Card type is not supported by our system, return null
            '(You can modify this code to support more (or less)
            ' card types as it pertains to your application)
            Return Nothing
        End If
    End Function

    Public Shared Function GetCardTestNumber(ByVal cardType As CreditCardTypeType) As String
        'According to PayPal, the valid test numbers that should be used
        'for testing card transactions are:
        'Credit Card Type              Credit Card Number
        'American Express              378282246310005
        'American Express              371449635398431
        'American Express Corporate    378734493671000
        'Diners Club                   30569309025904
        'Diners Club                   38520000023237
        'Discover                      6011111111111117
        'Discover                      6011000990139424
        'MasterCard                    5555555555554444
        'MasterCard                    5105105105105100
        'Visa                          4111111111111111
        'Visa                          4012888888881881
        'Src: https://www.paypal.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm
        'Credit: Scott Dorman, http://www.geekswithblogs.net/sdorman

        'Return bogus CC number that passes Luhn and format tests
        Select Case cardType
            Case CreditCardTypeType.Amex
                Return "3782 822463 10005"
            Case CreditCardTypeType.Discover
                Return "6011 1111 1111 1117"
            Case CreditCardTypeType.MasterCard
                Return "5105 1051 0510 5100"
            Case CreditCardTypeType.Visa
                Return "4111 1111 1111 1111"
            Case Else
                Return Nothing
        End Select
    End Function

    Public Shared Function PassesLuhnTest(ByVal cardNumber As String) As Boolean
        'Clean the card number- remove dashes and spaces
        cardNumber = cardNumber.Replace("-", "").Replace(" ", "")

        'Convert card number into digits array
        Dim digits As Integer() = New Integer(cardNumber.Length - 1) {}
        Dim len As Integer = 0
        While len < cardNumber.Length
            digits(len) = Int32.Parse(cardNumber.Substring(len, 1))
            len += 1
        End While

        'Luhn Algorithm
        'Adapted from code availabe on Wikipedia at
        'http://en.wikipedia.org/wiki/Luhn_algorithm
        Dim sum As Integer = 0
        Dim alt As Boolean = False
        Dim i As Integer = digits.Length - 1
        While i >= 0
            If alt Then
                digits(i) *= 2
                If digits(i) > 9 Then
                    digits(i) -= 9
                End If
            End If
            sum += digits(i)
            alt = Not alt
            i -= 1
        End While

        'If Mod 10 equals 0, the number is good and this will return true
        Return sum Mod 10 = 0
    End Function
End Class

''' <summary>
''' CreditCardTypeType copied for PayPal WebPayment Pro API
''' (If you use the PayPal API, you do not need this definition)
''' </summary>
Public Enum CreditCardTypeType
    Visa
    MasterCard
    Discover
    Amex
    Switch
    Solo
End Enum
