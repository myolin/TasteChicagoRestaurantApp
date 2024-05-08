import SwiftUI

struct CategoryView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        NavigationLink {
                            ListView(title: "American", viewModel: ListViewModel("American"))
                        } label: {
                            ZStack {
                                Image("american")
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                    .scaledToFill()
                                    .cornerRadius(20)
                                    .padding(.leading)
                            }
                        }
                        
                        NavigationLink {
                            ListView(title: "Chinese", viewModel: ListViewModel("Chinese"))
                        } label: {
                            Image("chinese")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        NavigationLink {
                            ListView(title: "Korean", viewModel: ListViewModel("Korean"))
                        } label: {
                            Image("korean")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.leading)
                        }
                        
                        NavigationLink {
                            ListView(title: "Japanese", viewModel: ListViewModel("Japanese"))
                        } label: {
                            Image("japanese")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        NavigationLink {
                            ListView(title: "Mexican", viewModel: ListViewModel("Mexican"))
                        } label: {
                            Image("mexican")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.leading)
                        }
                        
                        NavigationLink {
                            ListView(title: "Indian", viewModel: ListViewModel("Indian"))
                        } label: {
                            Image("indian")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        NavigationLink {
                            ListView(title: "Thai", viewModel: ListViewModel("Thai"))
                        } label: {
                            Image("thai")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.leading)
                        }
                        
                        NavigationLink {
                            ListView(title: "Vietnamese", viewModel: ListViewModel("Vietnamese"))
                        } label: {
                            Image("vietnamese")
                                .resizable()
                                .frame(width: 180, height: 180)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                }
                .padding(.top, 16)
                .navigationTitle("Cuisine")
            }
        }
    }
}

#Preview {
    CategoryView()
}

