import SwiftUI

struct CropView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CropViewModel
    
    private let image: UIImage
    private let maskShape: MaskShape
    private let configuration: SwiftyCropConfiguration
    private let onComplete: (UIImage?) -> Void
    private let localizableTableName: String
    
    init(
        image: UIImage,
        maskShape: MaskShape,
        configuration: SwiftyCropConfiguration,
        onComplete: @escaping (UIImage?) -> Void
    ) {
        self.image = image
        self.maskShape = maskShape
        self.configuration = configuration
        self.onComplete = onComplete
        _viewModel = StateObject(
            wrappedValue: CropViewModel(
                maskRadius: configuration.maskRadius,
                maxMagnificationScale: configuration.maxMagnificationScale
            )
        )
        localizableTableName = "Localizable"
    }
    
    var body: some View {
        VStack {
            Text("interaction_instructions")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
                .padding(.top, 30)
                .zIndex(1)
            
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(viewModel.scale)
                    .offset(viewModel.offset)
                    .opacity(0.2)
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    viewModel.imageSizeInView = geometry.size
                                }
                        }
                    )
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(viewModel.scale)
                    .offset(viewModel.offset)
                    .mask(
                        MaskShapeView(maskShape: maskShape)
                            .frame(width: viewModel.maskRadius * 2.2, height: viewModel.maskRadius * 2.2)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primary_color)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let sensitivity: CGFloat = 0.2
                        let scaledValue = (value.magnitude - 1) * sensitivity + 1
                        
                        let maxScaleValues = viewModel.calculateMagnificationGestureMaxValues()
                        viewModel.scale = min(max(scaledValue * viewModel.scale, maxScaleValues.0), maxScaleValues.1)
                        
                        let maxOffsetPoint = viewModel.calculateDragGestureMax()
                        let newX = min(max(viewModel.lastOffset.width, -maxOffsetPoint.x), maxOffsetPoint.x)
                        let newY = min(max(viewModel.lastOffset.height, -maxOffsetPoint.y), maxOffsetPoint.y)
                        viewModel.offset = CGSize(width: newX, height: newY)
                    }
                    .onEnded { _ in
                        viewModel.lastScale = viewModel.scale
                        viewModel.lastOffset = viewModel.offset
                    }
                    .simultaneously(
                        with: DragGesture()
                            .onChanged { value in
                                let maxOffsetPoint = viewModel.calculateDragGestureMax()
                                let newX = min(max(value.translation.width + viewModel.lastOffset.width, -maxOffsetPoint.x), maxOffsetPoint.x)
                                let newY = min(max(value.translation.height + viewModel.lastOffset.height, -maxOffsetPoint.y), maxOffsetPoint.y)
                                viewModel.offset = CGSize(width: newX, height: newY)
                            }
                            .onEnded { _ in
                                viewModel.lastOffset = viewModel.offset
                            }
                    )
            )
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color.clear) 
                .font(.appFont(type: .Regular, size: 17))
                .cornerRadius(8)
                .background(
                    Capsule()
                        .stroke(Color.off_white, lineWidth: 1)
                )
                Spacer()
                Button {
                    onComplete(viewModel.crop(image))
                    dismiss()
                } label: {
                    Text("Save")
                }
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color.red.opacity(0.7))
                .font(.appFont(type: .Regular, size: 17))
                .cornerRadius(22) 
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            .padding()
        }
        .background(Color.app_blue)
    }
    
    private struct MaskShapeView: View {
        let maskShape: MaskShape
        
        var body: some View {
            Group {
                switch maskShape {
                case .circle:
                    Circle()
                    
                case .square:
                    Rectangle()
                }
            }
        }
    }
}
