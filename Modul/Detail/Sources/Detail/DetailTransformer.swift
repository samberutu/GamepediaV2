import Foundation
import Core

public struct DetailTransformer: CoreMapper {
    public typealias Request = DetailResponse
    public typealias Domain = DetailModel
    public init() {}
    public func transformResponseToDomain(request: Request) -> Domain {
        return Domain(
            id: request.id ?? 0,
            name: request.name ?? "",
            website: request.website ?? "",
            backgroundImage: request.backgroundImage ?? "",
            reviewsCount: request.reviewsCount ?? 0,
            released: request.released ?? "",
            rating: request.rating ?? 0,
            ratingTop: request.ratingTop ?? 0,
            metacriticURL: request.metacriticURL ?? "",
            genres: request.genres.map({ developers in
                return developers.map { developer in
                    return DetatailDeveloperModel(id: developer.id ?? 0, name: developer.name ?? "", slug: developer.slug ?? "")
                }
            }) ?? [],
            welcomeDescription: request.welcomeDescription ?? "",
            parentPlatforms: request.parentPlatforms.map({ parentPlatforms in
                parentPlatforms.map { parentPlatform in
                    let newPlatform = DetailEsrbRatingModel(id: parentPlatform.platform?.id ?? 0, name: parentPlatform.platform?.name ?? "", slug: parentPlatform.platform?.slug  ?? "desktopcomputer")
                    return DetailParentPlatformModel(platform: newPlatform)
                }
            }) ?? [],
            esrbRating: DetailEsrbRatingModel(id: request.esrbRating?.id ?? 0, name: request.esrbRating?.name ?? "", slug: request.esrbRating?.slug ?? ""))
    }
}
