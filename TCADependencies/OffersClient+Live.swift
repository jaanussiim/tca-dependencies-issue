extension OffersClient {
    public static let live: OffersClient = {
        return OffersClient(
            onLoadOffers: {
                mode in
                
                print("Load offers for mode", mode)
                //make the api call
            }
        )
    }()
}
