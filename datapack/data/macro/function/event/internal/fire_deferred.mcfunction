# Doğrudan çağırmayın — event/fire_queued tarafindan queue'ya eklenir.
# queue_fire sirasinda queue[0] hala mevcuttur, bu yuzden
# queue[0].event'ten event adini okuyarak fire edebiliriz.
# Bu yaklaşım _fdeferred race condition'ini tamamen ortadan kaldırır.
function macro:event/fire with storage macro:engine queue[0]
