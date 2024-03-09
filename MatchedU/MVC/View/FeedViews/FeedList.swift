//
//  HomeView.swift
//  MatchedU
//
//  Created by Taimur imam on 17/02/24.

import SwiftUI
import SwiftyJSON

struct FeedList: View {
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = .green
       UITableView.appearance().backgroundColor = .green
    }
    
    var feed_Model = Feed_Model(from: JSON())
    @State var feeds = [Feed_Model]()
    @State private var isCreatFeedTapped = false
    @State private var isLoading = false
    @State private var page = 0

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                HStack{
                    NavigationLink(destination: ProfileView()){
                        HStack{
                            ProfileImage(url: loggedinUser.profile_image , width: 30, leading_padding: 0)
                                .padding(.leading , 15)
                            Text("Hi! \(loggedinUser.name)")
                                .foregroundStyle(Color.primary_color)
                                .font(.appFont(type: .Regular, size: 28))
                            }
                        }
                        Spacer()
                    //btnSearch()
                }
                .frame(height: 64)
                .background(Color.white )
                ZStack(alignment:.bottomTrailing){
                    ScrollView {
                        LazyVStack{
                            ForEach(feeds , id:\.id) { feed in
                                FeedItemView(feed_model: feed, feedDeleted: { deletedFeed in
                                    feeds = feeds.filter{ $0.id !=  deletedFeed.id}
                                })
                                .onAppear(){
                                    if feed.id == self.feeds.last?.id && !isLoading {
                                        isLoading = true
                                        getFeeds(isLoader: false )
                                    }
                                }
                            }
                            if isLoading{
                                Text("Loading.....")
                                    .foregroundStyle(Color.app_black)
                            }
                        }
                        .background(Color.white)
                    }
                    Button{
                        isCreatFeedTapped.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .btnCreatPostStyle()
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isCreatFeedTapped, content: {
                CreatPost {
                    getFeeds(isLoader: false)
                }
            })
            .task {
                if feeds.isEmpty{
                    getFeeds(isLoader: true)
                    page = 0
                }
            }
        }
    }
    
    //MARK: -  All Function will be here ********
    func getFeeds(isLoader : Bool){
        if isLoader{
            showHud()
        }
        page = page + 1
        
        FeedApiCall().getFeedList(page: "\(page)") { _response in
            if _response.isSuccess{ // data feed_list
                self.feeds += _response.completeJsonResp["data"]["feed_list"].arrayValue.map { Feed_Model(from: $0 )}
            }else{
                print("Some Bad Happned...")
            }
            isLoading = false
        }
    }
}

#Preview {
    FeedList()
}
