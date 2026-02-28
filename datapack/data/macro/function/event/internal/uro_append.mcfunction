# Doğrudan çağırmayın.
# Makro INPUT: { event:"<event>", func:"<exclude>", src:[...] }
# _uro.src[0]'ı events.<event>'e geri yazar.
$data modify storage macro:engine events.$(event) append from storage macro:engine _uro.src[0]
