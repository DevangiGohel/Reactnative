import React from "react";
import { StyleSheet, Text, View, TouchableOpacity } from "react-native";
import MapView from "react-native-maps";
import * as Location from "expo-location";

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      latitude: 35.681236,
      longitude: 139.767125,
    };
  }

  updateState(location) {
    this.setState({
      latitude: location.coords.latitude,
      longitude: location.coords.longitude,
    });
    console.log(this.state.latitude);
  }

  async componentDidMount() {
    try {
      let { status } = await Location.requestPermissionsAsync();
      if (status !== "granted") {
        return;
      }
      let location = await Location.getCurrentPositionAsync({});
      this.updateState(location);
    } catch (error) {
      console.log(error);
    }
  }
  render() {
    return (
      <View style={styles.container}>
        <MapView
          style={styles.mapView}
          showsUserLocation
          region={{
            latitude: this.state.latitude,
            longitude: this.state.longitude,
            latitudeDelta: 0.0922,
            longitudeDelta: 0.0421,
          }}
        >
          <MapView.Marker
            coordinate={{
              latitude: this.state.latitude,
              longitude: this.state.longitude,
            }}
          />
        </MapView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "flex-end",
  },

  mapView: {
    ...StyleSheet.absoluteFillObject,
  },

  buttonContainer: {
    flexDirection: "row",
    marginVertical: 20,
    backgroundColor: "transparent",
    alignItems: "center",
  },

  button: {
    width: 150,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "rgba(255,235,255,0.7)",
    paddingHorizontal: 18,
    paddingVertical: 12,
    borderRadius: 20,
  },

  buttonItem: {
    textAlign: "center",
  },
});
   