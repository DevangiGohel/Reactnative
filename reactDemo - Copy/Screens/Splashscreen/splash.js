import React, { useState } from "react";
import { StyleSheet, Text, View, Image } from "react-native";
import App from "../../App";

export default class splash extends React.Component {
  componentDidMount() {
    this.timeoutHandle = setTimeout(() => {
      this.props.navigation.navigate("dashboard");
    }, 3000);
  }
  componentWillUnmount() {
    clearTimeout(this.timeoutHandle);
  }
  render() {
    return (
      <View style={styles.container}>
        <Image
          source={{
            uri: "https://static.javatpoint.com/tutorial/react-native/images/react-native-tutorial.png",
          }}
          style={{ width: "100%", height: "100%", resizeMode: "contain" }}
        />
      </View>
    );
  }
}


const styles = StyleSheet.create({
  container: {
    width: "100%",
    height: "100%",
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#00BCD4",
  },
});
