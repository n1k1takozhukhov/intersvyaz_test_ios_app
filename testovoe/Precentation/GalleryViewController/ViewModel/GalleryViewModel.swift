import Foundation

final class GalleryViewModel {
    
    //MARK: Variables
    private let imageManager: APIManagerProtocol
    private var image: [ImageModel] = []
    var reloadCollectionView: (() -> Void)?
    
    
    init(imageManager: APIManagerProtocol = APIManager()) {
        self.imageManager = imageManager
    }
    
    
    //MARK: Selectors
    func fetchImage() {
        imageManager.fetchImage { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
                self?.reloadCollectionView?()
                
            case .failure(_): 
                print("er")
            }
        }
    }
    
    func numberOfImage() -> Int {
        return image.count
    }
    
    func image(at index: Int) -> ImageModel {
        return image[index]
    }
    
    func viewModelForImage(at index: Int) -> CollectionImageCellViewModel {
        let imageModel = image(at: index)
        return CollectionImageCellViewModel(imageModel: imageModel)
    }
}
