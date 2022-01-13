import React, { Component, useEffect, useRef, useState } from "react";

import {
  View,
  Text,
  ActivityIndicator,
  FlatList,
  Modal,
  StyleSheet,
  TouchableOpacity,
  Button,
} from "react-native";
import { Card } from "react-native-paper";

export default class apicall extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      Alert_Visibility: false,
      title: "",
      description: "",
      data: [],
      isLoading: true,
    };
  }
  Show_Custom_Alert(visible) {
    this.setState({ Alert_Visibility: visible });
  }

  componentDidMount() {
    fetch("https://reactnative.dev/movies.json")
      .then((response) => response.json())
      .then((json) => {
        this.setState({
          title: json.title,
          description: json.description,
          data: json.movies,
        });
        console.log(this.state.data);
        if (this.state.data.length > 0) {
          this.Show_Custom_Alert(true);
        }
      })
      .catch((error) => console.error(error))
      .finally(() => {
        this.setState({ isLoading: false });
      });
  }
  render() {
    const { title, description, data, isLoading } = this.state;

    // return (
    //   <View style={{ flex: 1, padding: 10 }}>
    //     <Text style={{ fontSize: 20, fontStyle: "italic" }}>
    //       Title : {title}
    //     </Text>
    //     <Text style={{ fontSize: 20, marginBottom: 10, fontStyle: "italic" }}>
    //       Description : {description}
    //     </Text>

    //     {isLoading ? (
    //       <ActivityIndicator />
    //     ) : (
    //       <FlatList
    //         data={data}
    //         keyExtractor={({ id }, index) => id}
    //         renderItem={({ item }) => (
    //           <Card
    //             style={{
    //               padding: 10,
    //               margin: 5,
    //               width: "100%",
    //               backgroundColor: "#ffffff",
    //               justifyContent: "center",
    //             }}
    //           >
    //             <Text style={{ color: "#808080", fontSize: 20 }}>
    //               {item.title}, {item.releaseYear}
    //             </Text>
    //           </Card>
    //         )}
    //       />
    //     )}
    //   </View>
    // );
    return (
      <View style={styles.MainContainer}>
        <Modal
          visible={this.state.Alert_Visibility}
          transparent={false}
          animationType={"fade"}
          onRequestClose={() => {
            this.Show_Custom_Alert(!this.state.Alert_Visibility);
          }}
        >
          <View
            style={{ flex: 1, alignItems: "center", justifyContent: "center" }}
          >
            <View style={styles.Alert_Main_View}>
              <Text style={styles.Alert_Title}>Obligatory Documents</Text>

              <View
                style={{ width: "100%", height: 2, backgroundColor: "#fff" }}
              />

              <FlatList
                style={{ margin: 10 }}
                data={data}
                keyExtractor={({ id }, index) => id}
                renderItem={({ item }) => (
                  <Card
                    style={{
                      padding: 8,
                      margin: 3,
                      width: "100%",
                      backgroundColor: "#F5F5F5",
                      justifyContent: "center",
                    }}
                  >
                    <Text style={{ color: "#808080", fontSize: 20 }}>
                      {item.title}, {item.releaseYear}
                    </Text>
                  </Card>
                )}
              />

              <View style={{ flexDirection: "row", marginBottom: 20 }}>
                <TouchableOpacity
                  style={{ backgroundColor: "#F5F5F5", margin: 4 }}
                  onPress={() => {
                    this.Show_Custom_Alert(!this.state.Alert_Visibility);
                  }}
                >
                  <Text style={styles.TextStyle}> Ok </Text>
                </TouchableOpacity>

                <TouchableOpacity
                  onPress={() => {
                    this.Show_Custom_Alert(!this.state.Alert_Visibility);
                  }}
                  style={{ backgroundColor: "#F5F5F5", margin: 4 }}
                >
                  <Text style={styles.TextStyle}> Cancel </Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        </Modal>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  MainContainer: {
    flex: 1,
    alignSelf: "center",
    justifyContent: "center",
    alignItems: "center",
  },

  alertView: {
    alignItems: "center",
    justifyContent: "center",
    alignSelf: "center",
  },

  Alert_Main_View: {
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "#fff",
    width: "70%",
    borderWidth: 1,
    borderColor: "#000",
    borderRadius: 7,
    alignSelf: "center",
  },

  Alert_Title: {
    fontSize: 25,
    fontWeight: "bold",
    color: "#000",
    textAlign: "center",
    padding: 5,
    margin: 5,
  },

  Alert_Message: {
    fontSize: 22,
    color: "#000",
    textAlign: "center",
    padding: 10,
  },
  TextStyle: {
    color: "#000",
    textAlign: "center",
    justifyContent: "space-around",
    fontSize: 22,
    padding: 10,
    fontWeight: "bold",
  },
});
